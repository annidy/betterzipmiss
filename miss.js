
//frida /Applications/BetterZip.app/Contents/MacOS/BetterZip -l miss.js --no-pause 
const RegistrationController = ObjC.classes.RegistrationController["- windowDidLoad"];

Interceptor.attach(RegistrationController.implementation, {
    onEnter: function (args) {
        console.log('windowDidLoad')
        var obj = new ObjC.Object(args[0])
        console.log(obj)
        setTimeout(function () {
            ObjC.schedule(ObjC.mainQueue, function () {
                console.log('close')
                obj.laterContinue_(null)
            })
        }, 1000)
    }
});