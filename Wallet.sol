pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Wallet {

    constructor() public {
        // check that contract's public key is set
        require(tvm.pubkey() != 0, 101);
        // Check that message has signature (msg.pubkey() is not zero) and message is signed with the owner's private key
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }
     modifier checkOwnerAndAccept {
        require(msg.pubkey() == tvm.pubkey(), 100);
	    tvm.accept();
		_;
	}
    function sendValueWithFee(address dest, uint128 value) public pure checkOwnerAndAccept {
        dest.transfer(value, true, 0);
    }
    function sendValueWithoutFee(address dest, uint128 value) public pure checkOwnerAndAccept {
        dest.transfer(value, true, 1);
    }
    function sendAllValueAndDestroy(address dest) public pure checkOwnerAndAccept {
        dest.transfer(1, true, 160);
    }
}
