
// clang -shared -undefined dynamic_lookup -o /Applications/BetterZip.app/Contents/MacOS/libMiss.dylib miss.m
// optool install -c load -p @executable_path/libMiss.dylib -t /Applications/BetterZip.app/Contents/MacOS/BetterZip
/*

*/


#import <Foundation/Foundation.h>
#import <objc/runtime.h>

static IMP windowDidLoad = NULL;
static void hooked_windowDidLoad(id obj, SEL _cmd) {
  [obj performSelector:NSSelectorFromString(@"laterContinue") afterDelay:1];
}

static IMP codesignCheck = NULL;
static void hooked_codesignCheck(id obj, SEL _cmd) {

}

__attribute__((constructor)) static void fool() {
  Method m1 =
      class_getInstanceMethod(NSClassFromString(@"RegistrationController"),
                              NSSelectorFromString(@"windowDidLoad"));
  windowDidLoad = method_getImplementation(m1);
  method_setImplementation(m1, (IMP)hooked_windowDidLoad);

  Method m2 =
      class_getClassMethod(NSClassFromString(@"AppController"),
                              NSSelectorFromString(@"codesignCheck"));
  codesignCheck = method_getImplementation(m2);
  method_setImplementation(m2, (IMP)hooked_codesignCheck);
}
