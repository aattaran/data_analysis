var restart = document.querySelector("#b");
var squares = document.querySelectorAll('td');

var clearBoard = function() {
  for (var i = 0; i<square.length; i++){
    squares[i].textContent = '';
  }
}
restart.addEventListener('click',clearBoard);



var mark = function() {
  if (this.textContent==='') {
    this.textContent = 'X';
  } else if (this.textContent==='X') {
    this.textContent = 'O';
  }else if (this.textContent==='O') {
    this.textContent = ' ';
  }

}

for (var i = 0; i < squares.length; i++) {
  squares[i].addEventListener('click', mark);
}
