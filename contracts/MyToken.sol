pragma solidity >=0.4.21 <0.6.0;

contract MyToken {
  //Tokenの名前、単位、バージョンの設定
  string  public name = "GX Token";
  string  public symbol = "GX";
  string  public standard = "GX Token v1.0";
  uint256 public totalSupply; 

  //Transfer event 必須
  event Transfer(
    address indexed _from, 
    address indexed _to, 
    uint256 _value
  );

  //Approval event 必須
  event Approval(
    address indexed _owner, 
    address indexed _spender, 
    uint256 _value
  );


  //各アカウントのバランスを表示するためadressをkeyにする
  mapping(address => uint256) public balanceOf;
  mapping(address => mapping(address => uint256)) public allowance;
  
  //constructor
  constructor(uint256 _initialSupply) public {
    //コントラクトの作成者に全てのトークンを持たせる
    balanceOf[msg.sender] = _initialSupply;
    totalSupply = _initialSupply;
  }

  //Transfer関数
  function transfer(address _to, uint256 _value) public returns (bool success) {
    //Tokenを送る人が十分なTokenを保有してるか確認
    require(balanceOf[msg.sender] >= _value);
    //msg.senderから_toに送金される
    balanceOf[msg.sender] -= _value;
    balanceOf[_to] += _value;
    //Transfer event の呼び出し
    emit Transfer(msg.sender, _to, _value);
    //boolをtrueに
    return true;
  }

  //Delegte transfer
  //approve finction
  function approve (address _spender, uint256 _value) public returns (bool success) {
    //allowance
    allowance[msg.sender][_spender] = _value;
    //Approval event
    emit Approval (msg.sender, _spender, _value);

    return true;
  }
  //fransferForm
  function transferFrom (address _from, address _to, uint256 _value) public returns (bool success) {

    require(_value <= balanceOf[_from]);
    require(_value <= allowance[_from][msg.sender] );

    balanceOf[_from] -= _value;
    balanceOf[_to] += _value;

    allowance[_from][msg.sender] -= _value;

    emit Transfer(_from, _to, _value);
    //require allowance number has big enought number 
    //change the balance
    //update allowance
    //transfer event
    //return booleun
    return true;
  }
}