import React, { useEffect, useState } from "react";
import twitterLogo from "./assets/twitter-logo.svg";
import saber from "./assets/saber.png";
import vader from "./assets/vader.gif";
import { ethers } from "ethers";
import { BsPencil } from "react-icons/bs";
import contractAbi from "./utils/contractAbi.json";
import { networks } from "./utils/networks";
import polygonLogo from "./assets/polygonlogo.png";
import ethLogo from "./assets/ethlogo.png";
import "./styles/App.css";

// Constants
const TWITTER_HANDLE = "priyansh_71";
const TWITTER_LINK = `https://twitter.com/${TWITTER_HANDLE}`;
const tld = ".sith";
const CONTRACT_ADDRESS = "0xA6f2DdBd8478801D59c61fc67666A80473dEAbBc";

const App = () => {

	const [network, setNetwork] = useState("");
	const [currentAccount, setCurrentAccount] = useState("");
	const [domain, setDomain] = useState("");
	const [why, setWhy] = useState("");
	const [editing, setEditing] = useState(false);
	const [loading, setLoading] = useState(false);
	const [mints, setMints] = useState([]);

	const connectWallet = async () => {
		try {
			const { ethereum } = window;

			if (!ethereum) {
				console.log("Please install MetaMask.");
			}

			const accounts = await ethereum.request({
				method: "eth_requestAccounts",
			});

			setCurrentAccount(accounts[0]);
		} catch (error) {
			console.log(error);
		}
	};

	const isWalletConnected = async () => {
		try {
			const { ethereum } = window;

			const accounts = await ethereum.request({ method: "eth_accounts" });

			if (accounts.length > 0) {
				const account = accounts[0];
				console.log("Found an authorized account : " + account);
			} else {
				console.log("No authorized account found.");
			}

			const chainId = await ethereum.request({ method: "eth_chainId" });
			setNetwork(networks[chainId]);

			ethereum.on("chainChanged", handleChainChanged);

			function handleChainChanged(_chainId) {
				window.location.reload();
			}
		} catch (error) {
			console.log("error: ", error);
		}
	};

	const switchNetwork = async () => {
		if (window.ethereum) {
			try {
				await window.ethereum.request({
					method: "wallet_switchEthereumChain",
					params: [{ chainId: "0x13881" }], // Check networks.js for hexadecimal network ids
				});
			} catch (error) {

				if (error.code === 4902) {
					try {
						await window.ethereum.request({
							method: "wallet_addEthereumChain",
							params: [
								{
									chainId: "0x13881",
									chainName: "Polygon Mumbai Testnet",
									rpcUrls: ["https://rpc-mumbai.maticvigil.com/"],
									nativeCurrency: {
										name: "Mumbai Matic",
										symbol: "MATIC",
										decimals: 18,
									},
									blockExplorerUrls: [
										"https://mumbai.polygonscan.com/",
									],
								},
							],
						});
					} catch (error) {
						console.log(error);
					}
				}
				console.log(error);
			}
		} else {
			alert(
				"MetaMask is not installed. Please install it to use this app: https://metamask.io/download.html"
			);
		}
	};

	const mintDomain = async () => {
		if (!domain) {
			return;
		}
		let price;
		if (domain.length < 3) {
			alert("Domain must be at least 3 characters long");
			return;
		} else if (
			domain.length === 3 ||
			domain.length === 4 ||
			domain.length === 5
		)
			price = "0.03";
		else price = "0.01";

		console.log("Minting domain", domain, "with price", price);
		try {
			const { ethereum } = window;
			if (ethereum) {
				const provider = new ethers.providers.Web3Provider(ethereum);
				const signer = provider.getSigner();
				const contract = new ethers.Contract(
					CONTRACT_ADDRESS,
					contractAbi.abi,
					signer
				);

				console.log("Going to pop wallet now to pay gas...");
				let tx = await contract.register(domain, {
					value: ethers.utils.parseEther(price),
				});
				const receipt = await tx.wait();

				if (receipt.status === 1) {
					console.log(
						"Domain minted! https://mumbai.polygonscan.com/tx/" + tx.hash
					);
					tx = await contract.setDark(domain, why);
					await tx.wait();
					console.log(
						"Record set! https://mumbai.polygonscan.com/tx/" + tx.hash
					);
					setTimeout(() => {
						fetchMints();
					  }, 2000);
					setWhy("");
					setDomain("");
				} else alert("Transaction failed! Please try again");
			}
		} catch (error) {
			console.log(error);
		}
	};

	const fetchMints = async () => {
		try {
		  const { ethereum } = window;
		  if (ethereum) {

			const provider = new ethers.providers.Web3Provider(ethereum);
			const signer = provider.getSigner();
			const contract = new ethers.Contract(CONTRACT_ADDRESS, contractAbi.abi, signer);
			const names = await contract.getAllNames();

			const mintRecords = await Promise.all(
				names.map(async (name) => {
					const vowReason = await contract.records(name);
					const owner = await contract.domains(name);
					return {
			  			id: names.indexOf(name),
			  			name: name,
			  			vow: vowReason,
			  			owner: owner,
					};
				}));

		  	setMints(mintRecords);
		  	}} 
			catch(error){
		  		console.log(error);
			}
	}
	  
	const updateDomain = async () => {
		if (!why || !domain) { return }
		setLoading(true);
		console.log("Updating domain", domain, "with vow : ", why);
		  try {
		  const { ethereum } = window;
		  if (ethereum) {
			const provider = new ethers.providers.Web3Provider(ethereum);
			const signer = provider.getSigner();
			const contract = new ethers.Contract(CONTRACT_ADDRESS, contractAbi.abi, signer);
	  
			let tx = await contract.setDark(domain, why);
			await tx.wait();
			console.log("Record set https://mumbai.polygonscan.com/tx/"+tx.hash);
	  
			fetchMints();
			setWhy("");
			setDomain("");
		  }
		  } catch(error) {
			console.log(error);
		  }
		setLoading(false);
	  }

	const renderInputForm = () => {
		if (network !== "Polygon Mumbai Testnet") {
			return (
				<div className="connect-wallet-container">
					<p>Please connect to the Polygon Mumbai Testnet.</p>
					<button
						className="cta-button mint-button"
						onClick={switchNetwork}
					>
						Switch to the Mumbai Testnet
					</button>
				</div>
			);
		}

		return (
			<div className="form-container">
				<label htmlFor="domain">Choose Domain </label>
				<div className="first-row">
					<input
						id="domain"
						type="text"
						value={domain}
						spellCheck="false"
						placeholder="domain"
						onChange={e => setDomain(e.target.value)}
					/>
					<p className="tld"> {tld} </p>
				</div>
				<textarea
					type="text"
					spellCheck="false"
					value={why}
					placeholder="Why do you want to join the dark side?"
					onChange={e => setWhy(e.target.value)}
					rows="4"
					cols="50"
					id="vowSetter"
				/>

				<div id="vow">Lord Vader will read this vow, do not lie.</div>

					{editing ? (
						<div className="button-container">
							<button className='cta-button mint-button' disabled={loading} onClick={updateDomain}>
								Set Vow
							</button>  
							<button className='cta-button mint-button' onClick={() => {
								setEditing(false)
								setDomain("");
								setWhy("");
							}}>
								Cancel
							</button>  
						</div>
					) : (
					<button className='cta-button mint-button' disabled={loading} onClick={mintDomain}>
						Mint Domain
					</button>  
				)}
			</div>
		);
	};

	const renderConnectButton = () => {
		return (
			<div className="connect-wallet-container">
				<img src={vader} height="320px" alt="Vader GIF" />
				<button
					className="cta-button connect-wallet-button"
					onClick={connectWallet}
				>
					Connect Wallet
				</button>
			</div>
		);
	};

	const renderMints = () => {
		if (currentAccount && mints.length > 0) {
		  return (
			<div className="mint-container">
			  <p className="subtitle"> Recent Darth Siders</p>
			  <div className="mint-list">
				{ mints.map((mint, index) => {
				  return (
					<div className="mint-item" key={index}>
					  <div className='mint-row'>
						<a className="link" href={`https://testnets.opensea.io/assets/mumbai/${CONTRACT_ADDRESS}/${mint.id}`} target="_blank" rel="noopener noreferrer">
						  <p className="underlined">{' '}{mint.name}{tld}{' '}</p>
						</a>
						{ mint.owner.toLowerCase() === currentAccount.toLowerCase() ?
						  <button className="edit-button" onClick={() => editRecord(mint.name)}>
							<BsPencil fontSize="15" color="white" className="edit-icon" />
							{/* <img className="edit-icon" src="https://img.icons8.com/metro/26/000000/pencil.png" alt="Edit button" /> */}
						  </button>
						  :
						  null
						}
					  </div>
				<p className="mint-vow"> {mint.vow} </p>
			  </div>)
			  })}
			</div>
		  </div>);
		}
	  };

	const editRecord = (name) => {
		setEditing(true);
		setDomain(name);
	}

	useEffect(() => {
		isWalletConnected();
	}, []);

	useEffect(() => {
		if (network === 'Polygon Mumbai Testnet') {
		  fetchMints();
		}
	  }, [currentAccount, network,why]);

	return (
		<div className="App">
			<div className="container">
				<div className="header-container">
					<header>
						<div className="left">
							<img src={saber} width="100px" alt="LightSaber" />
							<p className="title">Darth Sider.</p>
						</div>
						
						<div className="right">
							<img
								alt="Network logo"
								className="logo"
								src={
									network.includes("Polygon") ? polygonLogo : ethLogo
								}
							/>
							{currentAccount ? (
								<p>
									{" "}
									Wallet: {currentAccount.slice(0, 6)}...
									{currentAccount.slice(-4)}{" "}
								</p>
							) : (
								<p> Not connected </p>
							)}
						</div>
					</header>
				</div>

				{currentAccount ? renderInputForm() : renderConnectButton()}
				{mints ? renderMints() : null}

				<div className="footer-container">
					<img
						alt="Twitter Logo"
						className="twitter-logo"
						src={twitterLogo}
					/>
					<a
						className="footer-text"
						href={TWITTER_LINK}
						target="_blank"
						rel="noreferrer"
					>@{TWITTER_HANDLE}</a>
				</div>

			</div>
		</div>
	);
};

export default App;
