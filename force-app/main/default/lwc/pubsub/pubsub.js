var callbacks = {}; 


const register = (eventname, callback) => {
    if (!callbacks[eventname])
    {
        callbacks[eventname] = new Set();
    }
    callbacks[eventname].add(callback);
};

const unregister = (eventname, callback) => {
    if (callbacks[eventname])
    {
        callbacks[eventname].delete(callback);
    }
};//delete the callback from the callbacks variable 

const unregisterAll = () => { 
    callbacks = {};
}
//deletes all the component s from the callbacks param & removes all the lsiteners and related Callback functions 


const fire = (eventname, payload)=>{ 
    if (callbacks[eventname])
    { 
        callbacks[eventname].forEach(callback => { 
            try
            {
                callback(payload)
            } catch (error)
            { 
                window.console.log(error);
                //fail silently 
            }
        })
    }
}



export default { 
    register,
    unregister,
    unregisterAll,
    fire
}