function deleteAssistant(AssistantID, buttonRef){
    if(buttonRef!==null){
        $.ajax({
            url:"prwebStep2.json",
            method:"POST",
            data:{"AssistantID":AssistantID,},
            success:function(theResult){
                var ref = buttonRef;
                while((ref!==null)&&(ref.tagName!=="TR")){
                    ref=ref.parentElement;
                }
                if(ref!==null){
                    ref.parentElement.removeChild(ref);
                }
            },
            error:function(theResult,theStatus,theError){
                console.log("Error:"+theStatus+"-"+theResult);
            }
        });
    }
}