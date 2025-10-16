import { LightningElement } from 'lwc'
const BOOK_URL ='https://www.googleapis.com/books/v1/volumes?q=';

export default class BooksStore extends LightningElement {

    query='man'
    books=[]
    timer


    connectedCallback(){
        this.fetchbooksstoreapis();
    }
    fetchbooksstoreapis()
    {
        fetch(BOOK_URL+this.query).then(
            results=>results.json()
        ).then(data=>{
            this.books= data ? this.formatdata(data): [];
            console.log(this.books)
        }
        ).catch(error=>console.log(error))
    }
    FetchHanlderOnchange(event)
    {
        this.query=event.target.value;
        window.clearTimeout(this.timer)
        this.timer=setTimeout(()=>{
            this.fetchbooksstoreapis();
        }, 1000)
    }

    formatdata(data){
        let books=data.items.map(item=>{
            let id=item.id
            let thumbnail=item.volumeInfo.imageLinks && (item.volumeInfo.imageLinks.smallThumbnail || item.volumeInfo.imageLinks.thumbnail)
            let title=item.volumeInfo.title
            let publishdate=item.volumeInfo.publishedDate
            let averageRating =item.volumeInfo.averageRating || 'NA'
            return {id, thumbnail, publishdate, averageRating, title}
        })
        return books
    }
}