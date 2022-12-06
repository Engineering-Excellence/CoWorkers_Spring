'use strict'

function deleteCheck(url) {
    let answer = confirm('정말로 삭제하시겠습니까?')
    if (answer === true) {
        alert('삭제 완료')
        location = url
    }
}

function setting(commentID, mode, title, name, content) {
    let frm = document.commentForm;
    frm.commentID.value = commentID;
    frm.mode.value = mode;
    frm.commentBtn.value = title;
    frm.userName.value = name;
    while (content.indexOf('<br/>') != -1) {
        content = content.replace('<br/>', '\r\n');
    }
    frm.content.value = content;
}
