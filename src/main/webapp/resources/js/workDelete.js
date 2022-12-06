
function deleteCheck(url, idcheck) {
    let answer = confirm('정말로 삭제하시겠습니까?')
    if (answer === true) {
        if (idcheck === 'true') {
            alert('삭제 완료')
            location = url
        } else {
            alert('당신은 글쓴이가 아닙니다.')
        }
    }
}


// function deleteCheck(url) {
//     let answer = confirm('정말로 삭제하시겠습니까?')
//     if (answer === true) {
//         alert('삭제 완료')
//         location = url
//     }
// }