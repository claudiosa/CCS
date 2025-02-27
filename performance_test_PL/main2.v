fn main() {
    mut result := ''
    for i in 0..1000000 {
        result += '${i}Ok\r'
    }
    print(result)
}