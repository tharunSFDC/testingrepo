export function exportCSVFile(headers, totalData, fileTitle){
    console.log("totalData", totalData)
    if(!totalData || !totalData.length){
        return null
    }
    const jsonObject = JSON.stringify(totalData)
    const result = convertToCSV(jsonObject, headers)
 console.log("result", result)
    if(!result){
        return null
    }
    const blob = new Blob([result], {type: 'text/plain'});
    console.log('blob'+blob);
    const exportedFileName = fileTitle? fileTitle+'.csv':'export.csv'
    if(navigator.msSaveBlob){
        navigator.msSaveBlob(blob, exportedFileName)
    } else if (navigator.userAgent.match(/iPhone|iPad|iPod|Mac/i)){
        
        const link = window.document.createElement('a')
        link.href='data:text/csv;charset=utf-8,' + encodeURI(result);
        link.target = "_blank"
        link.download=exportedFileName
        link.click()
    } else {
        // const link = window.document.createElement('a')
        // if(link.download !== undefined){
        //     const url = URL.createObjectURL(blob)
        //     link.setAttribute("href", url)
        //     link.setAttribute("download", exportedFileName)
        //     link.style.visibility='hidden'
        //     document.body.appendChild(link)
        //     link.click()
        //     document.body.removeChild(link)
        // }
         const link = document.createElement("a");
        link.href = 'data:text/csv;charset=utf-8,' + encodeURI(result);
        link.target = "_blank";
        link.download = exportedFileName;
 
        // Append link to body and initiate the download
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    }
}
 
function convertToCSV(objArray, headers){
    const columnDelimiter = ','
    const lineDelimiter = '\r\n'
    const actualHeaderKey = Object.keys(headers)
    const headerToShow = Object.values(headers)
     
    let str = ''
    str+=headerToShow.join(columnDelimiter)
    str+=lineDelimiter
    const data = typeof objArray !=='object' ? JSON.parse(objArray):objArray
    data.forEach(obj=>{
        let line =''
        actualHeaderKey.forEach(key=>{
            if(line !=''){
                line+=columnDelimiter
            }
            
            let strItem = obj[key] ? obj[key]+'': ''
            line+=strItem? strItem.replace(/,/g, ''):strItem
        })
        str+=line+lineDelimiter
    })
    return str
}