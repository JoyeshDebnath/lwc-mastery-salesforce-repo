var callbacks={};//stores all the events and calbacks 
/**
 * Subscribing function 👇
 * @param {String} eventName --> name of the event to listen for  
 * @param {function} callback --> function to invoke when the said event fired 
 */
const register=(eventName,callback)=>{
    if(!callbacks[eventName]){
        callbacks[eventName]=new Set();
    }
    callbacks[eventName].add(callback);
}

//unregistering OR unsubscribing the event 
const unregister=(eventName,callback)=>{
    if(callbacks[eventName]){
        callbacks[eventName].delete(callback);
    }
}

/**
 * @param {String} eventName==> name of the event to fire
 * @param {*} payload ==> payload of the event 
 */
const fire=(eventName,payload)=>{
    if(callbacks[eventName]){
        callbacks[eventName].forEach(callback=>{
            try{
                callback(payload);
            }catch(error){
                console.error(error)
            }
        })
    }
}

export default{
    register,
    unregister,
    fire
}
