// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.10;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import { StringUtils } from "./libraries/StringUtils.sol";
import {Base64} from "./libraries/Base64.sol";

//0xA6f2DdBd8478801D59c61fc67666A80473dEAbBc

contract Domains is ERC721URIStorage {

    string svgPartOne = '<svg version="1.0" xmlns="http://www.w3.org/2000/svg" width="500" height="474.359" xml:space="preserve" viewBox="0 0 500 474.359"><path fill="url(#B)" d="M0 0h173.077v173.077H0z"/><g/><g/><path style="fill:#000" d="M264.636 56.482c-3.338.808-3.338.808 1.741 3.286 4.309 2.102 6.93 2.478 17.282 2.478 6.948 0 14.579.659 17.727 1.533 6.804 1.888 28.616 10.055 33.848 12.673 8.037 4.023 16.741 11.523 25.209 21.719 7.853 9.456 9.211 10.607 12.967 10.991 3.213.329 4.059.07 3.611-1.096-1.19-3.101-12.209-18.285-14.419-19.869-14.977-10.743-37.769-22.418-55.094-28.222-9.114-3.054-12.257-3.544-24.981-3.895-8.003-.22-16.055-.039-17.891.405"/><path style="fill:#000" d="M248.504 62.208c0 2.069 12.238 10.291 20.061 13.474 8.512 3.464 28.537 18.116 34.281 25.088 4.213 5.11 15.393 27.803 16.808 34.112.598 2.664 1.429 13.616 1.847 24.338.761 19.492.761 19.492-1.815 20.165-1.459.382-7.588-.735-14.123-2.568-6.352-1.785-14.654-3.772-18.449-4.419-3.795-.648-8.028-1.426-9.404-1.73-3.838-.846-3.139 2.441.968 4.565 4.549 2.352 44.474 19.399 45.437 19.399.408 0 .528-2.952.265-6.559-.537-7.409-1.222-6.909 11.697-8.5l5.802-.714.316-10.748.316-10.747 3.338 6.394c1.836 3.516 3.768 6.395 4.296 6.397.528.001 5.638-1.75 11.355-3.891 10.979-4.112 16.81-4.676 29.407-2.84 3.365.49 6.253.779 6.417.64.566-.479-6.114-16-9.03-20.972-4.788-8.169-26.637-35.235-34.83-43.144-6.543-6.318-9.81-8.378-23.191-14.624-19.218-8.972-25.402-10.842-35.861-10.842-7.306 0-10.139-.728-25.974-6.674-18.571-6.974-19.936-7.358-19.936-5.598"/><path style="fill:#000" d="M203.446 74.57c-20.448 1.798-38.849 16.032-59.115 45.726-8.78 12.863-13.258 22.817-17.086 37.967-6.131 24.276-7.055 32.383-6.819 59.85.185 21.554-.101 26.563-1.994 35.044-3.189 14.284-6.401 24.094-11.233 34.299-5.64 11.913-12.103 27.982-26.877 66.822a22907.168 22907.168 0 0 1-16.054 42.109c-2.081 5.416-3.783 10.297-3.783 10.847 0 2.6 4.735.388 12.824-5.998 11.237-8.866 15.001-11.406 36.128-24.363 18.748-11.5 23.782-13.588 37.261-15.444 10.247-1.411 14.351-3.447 16.561-8.213.863-1.863 2.343-10.145 3.288-18.406 1.173-10.26 3.278-20.485 6.643-32.262 2.71-9.485 5.75-22.098 6.757-28.031 1.955-11.52 2.629-13.366 12.127-33.198 9.183-19.177 22.059-34.428 35.103-41.578 4.3-2.359 9.368-5.886 11.262-7.84l3.443-3.552-4.535-10.894c-2.493-5.992-4.306-11.124-4.024-11.404.281-.281 3.707-1.058 7.615-1.728 7.258-1.243 20.312-.036 43.718 4.047 13.924 2.428 31.647 4.441 32.406 3.684.379-.381-.135-5.552-1.138-11.494-2.087-12.351-13.034-41.567-19.33-51.591-8.563-13.637-12.65-17.963-20.121-21.315-3.906-1.753-8.509-4.371-10.231-5.818-3.898-3.28-11.65-7.082-16.363-8.023-6.11-1.222-5.64 1.897 1.277 8.438 3.466 3.28 9.512 11.193 13.906 18.208 4.274 6.823 11.837 17.413 16.803 23.532 9.977 12.291 12.026 15.746 17.323 29.204 5.152 13.091 2.702 12.213-8.532-3.056-3.826-5.2-14.25-16.962-23.165-26.144-13.851-14.262-17.02-18.205-21.772-27.087-3.059-5.717-7.197-12.313-9.193-14.657-5.709-6.703-16.279-9.156-33.084-7.678m171.885 98.289c0 7.163 11.134 17.359 13.96 12.786.407-.659-.314-2.181-1.604-3.382-2.711-2.527-3.03-4.321-.763-4.321 3.321 0 5.468 1.622 8.529 6.447 1.859 2.932 5.253 6.195 8.209 7.896 6.235 3.587 20.038 18.961 23.081 25.708 4.73 10.485 18.818 54.271 23.545 73.172 2.712 10.847 6.955 29.517 9.43 41.491 4.28 20.714 8.415 37.47 9.526 38.581 1.398 1.399 1.828-8.354.75-17.104-3.364-27.359-24.291-101.852-39.027-138.92-4.507-11.34-13.782-29.437-16.679-32.545-4.914-5.277-17.023-11.295-25.057-12.456-13.203-1.909-13.899-1.776-13.899 2.649m-18.912 3.172c-5.667 2.29-6.142 2.764-6.452 6.45-.298 3.545 3.569 16.597 4.917 16.597.292 0 2.071-.796 3.952-1.767 3.241-1.677 3.386-2.03 2.738-6.751-.466-3.404-.158-6 .974-8.19 1.738-3.36 2.254-8.903.823-8.845-.459.018-3.589 1.146-6.954 2.507"/><path style="fill:#000" d="M259.784 191.251c-9.55 2.73-33.085 14.786-40.106 20.543-6.173 5.064-17.859 18.259-17.886 20.192-.037 2.863 13.396 11.265 15.718 9.832.446-.277 3.091-3.93 5.874-8.117 7.798-11.729 29.936-27.947 43.548-31.905 9.196-2.672 32.191-1.843 39.555 1.429 2.829 1.255 5.446 2.777 5.818 3.38 1.056 1.707-6.185 2.467-23.613 2.482-14.87.01-16.451.217-22.529 2.945-3.595 1.613-6.538 3.413-6.538 4 0 .588 1.037 2.521 2.301 4.298 1.786 2.506 3.169 3.233 6.169 3.233 7.714 0 12.479 8.467 8.669 15.414-2.965 5.408-4.986 6.418-9.273 4.642-4.317-1.79-6.755-6.222-6.755-12.292 0-3.289-.957-5.976-3.387-9.506-3.388-4.921-3.388-4.921-6.397-3.016-9.809 6.209-21.366 15.422-21.366 17.033 0 2.593 13.735 13.391 22.013 17.309 8.309 3.932 22.928 6.362 34.724 5.777 8.278-.412 10.729-1.064 19.654-5.24l10.198-4.768 6.517 5.403c3.586 2.969 7.758 6.217 9.272 7.215 2.753 1.813 2.753 1.813.528 4.313-2.143 2.41-2.713 2.477-15.574 1.822-19.212-.977-36.342 1.847-48.396 7.976-5.69 2.892-6.11 3.381-6.004 6.941.063 2.109 2.419 9.643 5.238 16.746 3.297 8.312 5.393 15.56 5.883 20.337.419 4.082 1.137 7.652 1.595 7.936.459.285 2.881-2.926 5.379-7.133 7.586-12.767 23.698-22.963 45.207-28.605 6.117-1.606 11.432-3.406 11.806-4.001.374-.595.973-4.668 1.332-9.052.359-4.385 1.647-10.632 2.864-13.885l2.214-5.912-7.046-9.13c-6.717-8.703-7.08-9.489-7.764-16.893-.396-4.269-.987-10.069-1.31-12.889-.592-5.123-.592-5.123 5.888-6.339 3.563-.669 9.293-1.542 12.734-1.941 6.255-.724 6.255-.724 6.773 2.809l.517 3.534-9.276-.773c-9.277-.771-9.277-.771-9.277 2.141 0 2.563.447 2.913 3.739 2.913 2.056 0 6.061.318 8.901.708 4.041.554 5.16 1.158 5.16 2.782 0 1.84-.944 2.074-8.344 2.074-6.6 0-8.379.348-8.51 1.667a294.085 294.085 0 0 0-.278 2.968c-.078.901 2.314 1.22 7.809 1.042 6.588-.213 8.042.062 8.648 1.641.996 2.597.282 3.063-5.767 3.759-3.646.418-5.238 1.109-5.238 2.27 0 1.25 1.812 1.817 7.232 2.267 5.721.476 8.489 1.405 13.248 4.448 5.814 3.718 6.444 3.861 18.71 4.25 14.926.474 19.685-.867 26.996-7.619 4.697-4.338 4.73-4.419 4.224-10.811-.591-7.509-6.542-18.686-12.026-22.59-5.693-4.054-21.988-4.368-27.119-.524-2.062 1.545-2.049 1.776.557 10.058 2.066 6.57 3.326 8.82 5.596 10.009 3.759 1.968 4.972 6.541 2.668 10.056-2.37 3.62-6.654 4.498-11.25 2.307-4.902-2.337-5.924-6.21-2.802-10.597 1.285-1.803 2.326-4.453 2.313-5.888-.034-4.053-2.884-13.752-3.991-13.586-.546.084-2.119.491-3.496.909-3.388 1.028-3.316-1.577.132-4.815 3.513-3.301 16.738-7.871 22.856-7.901 8.963-.043 16.742 3.215 23.141 9.694 7.726 7.822 8.577 11.224 7.639 30.563-.822 17.006-.428 18.53 7.522 28.943 8.223 10.771 8.226 12.698.041 28.378-7.817 14.98-8.165 16.205-6.909 24.291 1.791 11.51 5.133 20.524 9.334 25.174 5.298 5.863 6.788 9.245 5.011 11.383-.753.909-4.707 3.484-8.786 5.72-9.7 5.322-48.718 30.37-58.274 37.409-4.109 3.027-9.254 7.932-11.433 10.897-2.179 2.968-5.745 6.962-7.926 8.879-4.694 4.12-5.822 3.602-9.977-4.594-1.486-2.932-5.863-9.219-9.734-13.978-9.471-11.648-25.219-33.172-25.219-34.47 0-1.733 5.009-5.887 7.098-5.887 3.998 0 6.127 2.409 9.081 10.276 4.686 12.473 12.61 27.238 16.28 30.324 4.362 3.671 6.508 3.519 11.713-.827 2.382-1.989 12.728-8.591 22.991-14.673 18.085-10.714 31.038-20.336 35.485-26.352 1.736-2.347 1.914-3.374.917-5.237-1.068-1.999-2.19-2.292-8.179-2.146-3.816.093-11.946-.436-18.064-1.176-8.173-.988-15.406-1.05-27.258-.234-8.871.61-21.144 1.118-27.272 1.128-8.994.012-11.942.446-15.293 2.241-2.459 1.318-6.306 2.233-9.441 2.241-7.491.024-8.948 1.171-7.239 5.701.745 1.976 1.146 3.802.89 4.059-.257.258-4.128.879-8.603 1.383-4.474.505-14.943 2.176-23.263 3.714-8.32 1.539-20.464 3.417-26.99 4.177-8.05.938-12.338 1.94-13.343 3.124-.814.959-2.626 6.092-4.021 11.405-3.135 11.921-2.641 15.181 3.935 26.01 2.71 4.464 4.928 8.478 4.928 8.916 0 .438-1.752 2.936-3.893 5.549-2.141 2.613-3.893 5.232-3.893 5.815 0 2.29 5.962 11.566 8.506 13.234 2.173 1.423 4.457 1.616 11.93 1.01 7.377-.598 11.466-.266 20.268 1.641 10.035 2.176 12.882 2.318 31.594 1.583 11.536-.455 23.015-1.492 26.143-2.36 3.068-.853 11.338-2.56 18.373-3.793 14.115-2.474 13.068-1.804 25.032-16.03 4.308-5.121 4.7-5.318 12.239-6.161 11.307-1.26 37.114-12.52 53.333-23.267 17.56-11.637 34.085-23.78 35.201-25.864 1.15-2.149-1.035-16.088-6.34-40.442-.934-4.283-4.389-21.305-7.679-37.827-8.188-41.116-17.433-72.17-24.904-83.654-5.832-8.963-13.811-17.53-18.333-19.674-5.97-2.833-12.293-2.181-31.318 3.231-19.752 5.617-31.147 7.714-37.378 6.88-2.297-.308-8.674-3.156-14.171-6.329-11.334-6.541-19.376-9.342-31.766-11.064-11.815-1.643-18.882-1.389-27.188.986"/><path style="fill:#000" d="M200.281 247.709c-3.132.807-7.04 10.961-9.622 25-1.276 6.927-2.547 13.679-2.828 15.003-.422 1.997.772 3.162 6.996 6.823 4.13 2.43 14.515 8.65 23.084 13.826 19.132 11.557 42.4 23.818 55.286 29.136 10.539 4.348 10.91 4.451 10.91 3.014 0-.537-5.132-3.1-11.404-5.697-14.047-5.817-31.733-17-33.276-21.039-1.082-2.833-4.272-25.938-4.272-30.934 0-1.4.376-2.544.836-2.543.459 0 3.838 2.745 7.509 6.101 3.671 3.356 7.009 6.108 7.416 6.117 1.79.042 8.199 9.757 11.605 17.591 4.399 10.117 6.601 11.799 5.766 4.402-.319-2.837-3.231-10.538-6.693-17.715-4.813-9.971-7.312-13.76-11.646-17.657-5.559-4.995-45.479-32.327-46.866-32.088-.409.071-1.668.366-2.799.659m160.844 13.934c-5.63 1.179-5.294 2.596.858 3.637 6.439 1.088 8.887 4.704 8.95 13.222.051 6.803.051 6.803 11.145 16.705 14.263 12.729 23.331 19.75 24.859 19.253 2.476-.806 12.164-24.859 13.656-33.898.789-4.786-.536-6.157-9.44-9.781-6.016-2.448-10.026-3.182-20.803-3.808-11.002-.64-14.328-1.262-18.913-3.55-4.75-2.368-6.257-2.63-10.312-1.781m-37.296 50.714c-13.724 17.726-16.845 20.717-26.059 24.988-3.184 1.476-6.559 3.321-7.501 4.104-2.146 1.782-2.234 7.123-.143 8.858 2.255 1.87 7.959 2.108 7.592.313-.561-2.747 2.074-5.815 7.287-8.483 3.386-1.731 6.226-4.295 8.01-7.23 4.002-6.58 4.117-6.472 6.219 5.743.664 3.859 1.001 4.172 4.489 4.172 3.427 0 3.769-.298 3.769-3.258 0-1.792-.519-7.003-1.158-11.582-1.049-7.541-.951-8.663 1.049-11.953 2.208-3.629 2.208-3.629 3.363-.936.933 2.171 6.758 24.777 6.758 26.222 0 .859 7.696.324 8.252-.572.327-.53-.136-4.409-1.029-8.622-.893-4.211-1.632-11.038-1.642-15.167-.017-7.151.106-7.509 2.602-7.509 2.786 0 2.868.269 7.582 24.197 1.368 6.954 1.368 6.954 6.153 6.954 2.631 0 4.779-.376 4.773-.836-.006-.459-.752-7.091-1.659-14.741-.907-7.648-1.654-14.033-1.659-14.186-.005-.153.984-.279 2.195-.279 2.262 0 2.617.864 3.888 9.457.362 2.448 1.484 8.081 2.492 12.514l1.836 8.066h10.718v-7.232c0-3.979.374-7.233.835-7.231.459.001 2.262 2.263 4.009 5.027 1.745 2.761 5.326 6.786 7.954 8.94l4.78 3.917 3.977-2.698 3.976-2.698-3.511-4.854c-9.542-13.188-20.611-26.039-27.634-32.082l-7.791-6.706-11.932-.011c-6.562-.008-13.723-.309-15.913-.671-3.983-.659-3.983-.659-16.926 16.056m-141.339-6.193c-1 3.823-3.607 15.463-5.791 25.864-7.123 33.901-5.598 31.747-27.662 39.061-17.942 5.947-23.676 8.643-41.676 19.602-10.32 6.283-15.251 10.235-24.357 19.52-6.278 6.404-11.724 12.872-12.101 14.376-1.568 6.25 4.342 10.995 21.013 16.869 11.445 4.033 23.698 5.756 41.088 5.777 28.817.037 50.211-12.044 52.605-29.703.318-2.358.787-10.355 1.039-17.766.501-14.781 1.399-17.58 7.528-23.456 5.478-5.255 9.073-6.381 38.281-11.977 39.086-7.489 39.912-7.688 40.293-9.67.292-1.517-2.037-1.838-17.238-2.365-9.665-.337-24.085-1.629-32.038-2.87-7.955-1.243-19.109-2.609-24.79-3.038-5.679-.428-10.592-1.209-10.917-1.738-.327-.528-.258-2.017.153-3.31.715-2.258 1.238-2.327 13.143-1.74 11.491.565 41.11 3.592 60.831 6.216 4.609.613 10.84.763 13.844.335l5.463-.782-10.508-4.151c-5.779-2.285-14.762-5.588-19.962-7.343-11.748-3.963-17.64-6.94-37.112-18.739-13.393-8.114-27.56-15.928-28.887-15.928-.233 0-1.241 3.129-2.241 6.954m228.817 39.769c-4.859 1.96-4.713 11.916.223 15.152 3.587 2.349 6.629 1.311 5.011-1.71-1.336-2.493-1.568-8.982-.327-9.006.459-.01 1.584-.491 2.498-1.068 1.427-.902 1.347-1.29-.557-2.729-2.527-1.91-3.477-1.998-6.85-.639"/><path style="fill:#000" d="M198.139 419.042c-.606 5.369-2.161 7.341-12.593 15.952-4.137 3.414-5.817 10.514-3.302 13.939 1.362 1.854 2.79 2.099 10.793 1.855 5.601-.17 9.729-.827 10.506-1.667 1.707-1.848 3.798-10.762 3.798-16.19 0-4.437-5.88-19.131-7.655-19.131-.526 0-1.221 2.359-1.547 5.242"/><text x="15" y="45" font-size="28" font-family="fantasy" font-weight="bold">';

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    address payable public owner;

    error Unauthorized();
    error AlreadyRegistered();
    error InvalidName(string name);

    string svgPartTwo = '</text></svg>';
    string public tld;

    mapping(string => address) public domains; // takes name returns address
    mapping(string => string) public records;   // takes name returns why
    mapping (uint => string) public names;


    constructor(string memory _tld ) payable ERC721("DarthSider.", "DS") {
        owner = payable(msg.sender);
        tld = _tld;
    }


    function getAllNames() public view returns (string[] memory) {
        string[] memory allNames = new string[](_tokenIds.current());
        for (uint i = 0; i < _tokenIds.current(); i++) {
            allNames[i] = names[i];
            console.log("Name for token %d is %s", i, allNames[i]);
        }

        return allNames;
    }

    function compareStrings(string memory a, string memory b) public pure returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
    }

    function price(string calldata _name) public pure returns (uint) {
        uint len = StringUtils.strlen(_name);
        require(len > 0);
            if (len <= 5) {
            return 3 * 10**16;          // 0.03 MATIC
        } else {
            return 1 * 10**16;          // 0.01 MATIC
        }
    }

    function register(string calldata name) public payable {
        if (domains[name] != address(0)) revert AlreadyRegistered();
        if (!valid(name)) revert InvalidName(name);
        uint _price = price(name);
        require(msg.value >= _price, "Not enough Matic paid.");
        
        string memory _name = string(abi.encodePacked(name, ".", tld));

        string memory finalSvg = string(abi.encodePacked(svgPartOne, _name, svgPartTwo));
        uint256 newRecordId = _tokenIds.current();
        uint256 length = StringUtils.strlen(name);
        string memory strLen = Strings.toString(length);

        string memory json = Base64.encode(
        abi.encodePacked(
            '{"name": "',
            _name,
            '", "description": "A domain on the Darth Sider network.", "image": "data:image/svg+xml;base64,',
            Base64.encode(bytes(finalSvg)),
            '","length":"',
            strLen,
            '"}'
        ));

        string memory finalTokenUri = string( abi.encodePacked("data:application/json;base64,", json));

        _safeMint(msg.sender, newRecordId);
        _setTokenURI(newRecordId, finalTokenUri);
        domains[name] = msg.sender;
        names[newRecordId] = name;
        _tokenIds.increment();
    }

    function valid(string calldata name) public pure returns(bool) {
        if (compareStrings(name, "jedi")) return false;
        return StringUtils.strlen(name) >= 3 && StringUtils.strlen(name) <= 10;
    }

    function getAddress(string calldata _name) public view returns (address) {
        return domains[_name];
    }

    function setDark(string calldata _name, string calldata _why) public {
        if (domains[_name] != msg.sender) revert Unauthorized();
        records[_name] = _why;
    }

    function getDark(string calldata _name) public view returns(string memory) {
        return records[_name];
    }

    modifier onlyOwner() {
        require(isOwner());
    _;
    }

    function isOwner() public view returns (bool) {
        return msg.sender == owner;
    }

    function withdraw() public onlyOwner {
        uint amount = address(this).balance;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Failed to withdraw Matic");
    } 
}