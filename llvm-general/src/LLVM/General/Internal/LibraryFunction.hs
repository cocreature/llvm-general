{-# LANGUAGE MultiParamTypeClasses #-}
module LLVM.General.Internal.LibraryFunction where

import qualified LLVM.General.Internal.FFI.LLVMCTypes as FFI

import LLVM.General.Internal.Coding


-- | <http://llvm.org/doxygen/namespacellvm_1_1LibFunc.html#abf8f6830387f338fed0bce2e65108c6f>
data LibraryFunction
  = LF__under_IO_getc
  | LF__under_IO_putc
  | LF__ZdaPv
  | LF__ZdaPvRKSt9nothrow_t
  | LF__ZdlPv
  | LF__ZdlPvRKSt9nothrow_t
  | LF__Znaj
  | LF__ZnajRKSt9nothrow_t
  | LF__Znam
  | LF__ZnamRKSt9nothrow_t
  | LF__Znwj
  | LF__ZnwjRKSt9nothrow_t
  | LF__Znwm
  | LF__ZnwmRKSt9nothrow_t
  | LF__cospi
  | LF__cospif
  | LF__cxa_atexit
  | LF__cxa_guard_abort
  | LF__cxa_guard_acquire
  | LF__cxa_guard_release
  | LF__dunder_isoc99_scanf
  | LF__dunder_isoc99_sscanf
  | LF__memcpy_chk
  | LF__sincospi_stret
  | LF__sincospif_stret
  | LF__sinpi
  | LF__sinpif
  | LF__sqrt_finite
  | LF__sqrtf_finite
  | LF__sqrtl_finite
  | LF__dunder_strdup
  | LF__dunder_strndup
  | LF__dunder_strtok_r
  | LF__abs
  | LF__access
  | LF__acos
  | LF__acosf
  | LF__acosh
  | LF__acoshf
  | LF__acoshl
  | LF__acosl
  | LF__asin
  | LF__asinf
  | LF__asinh
  | LF__asinhf
  | LF__asinhl
  | LF__asinl
  | LF__atan
  | LF__atan2
  | LF__atan2f
  | LF__atan2l
  | LF__atanf
  | LF__atanh
  | LF__atanhf
  | LF__atanhl
  | LF__atanl
  | LF__atof
  | LF__atoi
  | LF__atol
  | LF__atoll
  | LF__bcmp
  | LF__bcopy
  | LF__bzero
  | LF__calloc
  | LF__cbrt
  | LF__cbrtf
  | LF__cbrtl
  | LF__ceil
  | LF__ceilf
  | LF__ceill
  | LF__chmod
  | LF__chown
  | LF__clearerr
  | LF__closedir
  | LF__copysign
  | LF__copysignf
  | LF__copysignl
  | LF__cos
  | LF__cosf
  | LF__cosh
  | LF__coshf
  | LF__coshl
  | LF__cosl
  | LF__ctermid
  | LF__exp
  | LF__exp10
  | LF__exp10f
  | LF__exp10l
  | LF__exp2
  | LF__exp2f
  | LF__exp2l
  | LF__expf
  | LF__expl
  | LF__expm1
  | LF__expm1f
  | LF__expm1l
  | LF__fabs
  | LF__fabsf
  | LF__fabsl
  | LF__fclose
  | LF__fdopen
  | LF__feof
  | LF__ferror
  | LF__fflush
  | LF__ffs
  | LF__ffsl
  | LF__ffsll
  | LF__fgetc
  | LF__fgetpos
  | LF__fgets
  | LF__fileno
  | LF__fiprintf
  | LF__flockfile
  | LF__floor
  | LF__floorf
  | LF__floorl
  | LF__fmax
  | LF__fmaxf
  | LF__fmaxl
  | LF__fmin
  | LF__fminf
  | LF__fminl
  | LF__fmod
  | LF__fmodf
  | LF__fmodl
  | LF__fopen
  | LF__fopen64
  | LF__fprintf
  | LF__fputc
  | LF__fputs
  | LF__fread
  | LF__free
  | LF__frexp
  | LF__frexpf
  | LF__frexpl
  | LF__fscanf
  | LF__fseek
  | LF__fseeko
  | LF__fseeko64
  | LF__fsetpos
  | LF__fstat
  | LF__fstat64
  | LF__fstatvfs
  | LF__fstatvfs64
  | LF__ftell
  | LF__ftello
  | LF__ftello64
  | LF__ftrylockfile
  | LF__funlockfile
  | LF__fwrite
  | LF__getc
  | LF__getc_unlocked
  | LF__getchar
  | LF__getenv
  | LF__getitimer
  | LF__getlogin_r
  | LF__getpwnam
  | LF__gets
  | LF__gettimeofday
  | LF__htonl
  | LF__htons
  | LF__iprintf
  | LF__isascii
  | LF__isdigit
  | LF__labs
  | LF__lchown
  | LF__ldexp
  | LF__ldexpf
  | LF__ldexpl
  | LF__llabs
  | LF__log
  | LF__log10
  | LF__log10f
  | LF__log10l
  | LF__log1p
  | LF__log1pf
  | LF__log1pl
  | LF__log2
  | LF__log2f
  | LF__log2l
  | LF__logb
  | LF__logbf
  | LF__logbl
  | LF__logf
  | LF__logl
  | LF__lstat
  | LF__lstat64
  | LF__malloc
  | LF__memalign
  | LF__memccpy
  | LF__memchr
  | LF__memcmp
  | LF__memcpy
  | LF__memmove
  | LF__memrchr
  | LF__memset
  | LF__memset_pattern16
  | LF__mkdir
  | LF__mktime
  | LF__modf
  | LF__modff
  | LF__modfl
  | LF__nearbyint
  | LF__nearbyintf
  | LF__nearbyintl
  | LF__ntohl
  | LF__ntohs
  | LF__open
  | LF__open64
  | LF__opendir
  | LF__pclose
  | LF__perror
  | LF__popen
  | LF__posix_memalign
  | LF__pow
  | LF__powf
  | LF__powl
  | LF__pread
  | LF__printf
  | LF__putc
  | LF__putchar
  | LF__puts
  | LF__pwrite
  | LF__qsort
  | LF__read
  | LF__readlink
  | LF__realloc
  | LF__reallocf
  | LF__realpath
  | LF__remove
  | LF__rename
  | LF__rewind
  | LF__rint
  | LF__rintf
  | LF__rintl
  | LF__rmdir
  | LF__round
  | LF__roundf
  | LF__roundl
  | LF__scanf
  | LF__setbuf
  | LF__setitimer
  | LF__setvbuf
  | LF__sin
  | LF__sinf
  | LF__sinh
  | LF__sinhf
  | LF__sinhl
  | LF__sinl
  | LF__siprintf
  | LF__snprintf
  | LF__sprintf
  | LF__sqrt
  | LF__sqrtf
  | LF__sqrtl
  | LF__sscanf
  | LF__stat
  | LF__stat64
  | LF__statvfs
  | LF__statvfs64
  | LF__stpcpy
  | LF__stpncpy
  | LF__strcasecmp
  | LF__strcat
  | LF__strchr
  | LF__strcmp
  | LF__strcoll
  | LF__strcpy
  | LF__strcspn
  | LF__strdup
  | LF__strlen
  | LF__strncasecmp
  | LF__strncat
  | LF__strncmp
  | LF__strncpy
  | LF__strndup
  | LF__strnlen
  | LF__strpbrk
  | LF__strrchr
  | LF__strspn
  | LF__strstr
  | LF__strtod
  | LF__strtof
  | LF__strtok
  | LF__strtok_r
  | LF__strtol
  | LF__strtold
  | LF__strtoll
  | LF__strtoul
  | LF__strtoull
  | LF__strxfrm
  | LF__system
  | LF__tan
  | LF__tanf
  | LF__tanh
  | LF__tanhf
  | LF__tanhl
  | LF__tanl
  | LF__times
  | LF__tmpfile
  | LF__tmpfile64
  | LF__toascii
  | LF__trunc
  | LF__truncf
  | LF__truncl
  | LF__uname
  | LF__ungetc
  | LF__unlink
  | LF__unsetenv
  | LF__utime
  | LF__utimes
  | LF__valloc
  | LF__vfprintf
  | LF__vfscanf
  | LF__vprintf
  | LF__vscanf
  | LF__vsnprintf
  | LF__vsprintf
  | LF__vsscanf
  | LF__write
  deriving (Eq, Ord, Enum, Bounded, Read, Show)
instance Monad m => EncodeM m LibraryFunction FFI.LibFunc where
  encodeM LF__under_IO_getc = return (FFI.LibFunc 0)
  encodeM LF__under_IO_putc = return (FFI.LibFunc 1)
  encodeM LF__ZdaPv = return (FFI.LibFunc 2)
  encodeM LF__ZdaPvRKSt9nothrow_t = return (FFI.LibFunc 3)
  encodeM LF__ZdlPv = return (FFI.LibFunc 4)
  encodeM LF__ZdlPvRKSt9nothrow_t = return (FFI.LibFunc 5)
  encodeM LF__Znaj = return (FFI.LibFunc 6)
  encodeM LF__ZnajRKSt9nothrow_t = return (FFI.LibFunc 7)
  encodeM LF__Znam = return (FFI.LibFunc 8)
  encodeM LF__ZnamRKSt9nothrow_t = return (FFI.LibFunc 9)
  encodeM LF__Znwj = return (FFI.LibFunc 10)
  encodeM LF__ZnwjRKSt9nothrow_t = return (FFI.LibFunc 11)
  encodeM LF__Znwm = return (FFI.LibFunc 12)
  encodeM LF__ZnwmRKSt9nothrow_t = return (FFI.LibFunc 13)
  encodeM LF__cospi = return (FFI.LibFunc 14)
  encodeM LF__cospif = return (FFI.LibFunc 15)
  encodeM LF__cxa_atexit = return (FFI.LibFunc 16)
  encodeM LF__cxa_guard_abort = return (FFI.LibFunc 17)
  encodeM LF__cxa_guard_acquire = return (FFI.LibFunc 18)
  encodeM LF__cxa_guard_release = return (FFI.LibFunc 19)
  encodeM LF__dunder_isoc99_scanf = return (FFI.LibFunc 20)
  encodeM LF__dunder_isoc99_sscanf = return (FFI.LibFunc 21)
  encodeM LF__memcpy_chk = return (FFI.LibFunc 22)
  encodeM LF__sincospi_stret = return (FFI.LibFunc 23)
  encodeM LF__sincospif_stret = return (FFI.LibFunc 24)
  encodeM LF__sinpi = return (FFI.LibFunc 25)
  encodeM LF__sinpif = return (FFI.LibFunc 26)
  encodeM LF__sqrt_finite = return (FFI.LibFunc 27)
  encodeM LF__sqrtf_finite = return (FFI.LibFunc 28)
  encodeM LF__sqrtl_finite = return (FFI.LibFunc 29)
  encodeM LF__dunder_strdup = return (FFI.LibFunc 30)
  encodeM LF__dunder_strndup = return (FFI.LibFunc 31)
  encodeM LF__dunder_strtok_r = return (FFI.LibFunc 32)
  encodeM LF__abs = return (FFI.LibFunc 33)
  encodeM LF__access = return (FFI.LibFunc 34)
  encodeM LF__acos = return (FFI.LibFunc 35)
  encodeM LF__acosf = return (FFI.LibFunc 36)
  encodeM LF__acosh = return (FFI.LibFunc 37)
  encodeM LF__acoshf = return (FFI.LibFunc 38)
  encodeM LF__acoshl = return (FFI.LibFunc 39)
  encodeM LF__acosl = return (FFI.LibFunc 40)
  encodeM LF__asin = return (FFI.LibFunc 41)
  encodeM LF__asinf = return (FFI.LibFunc 42)
  encodeM LF__asinh = return (FFI.LibFunc 43)
  encodeM LF__asinhf = return (FFI.LibFunc 44)
  encodeM LF__asinhl = return (FFI.LibFunc 45)
  encodeM LF__asinl = return (FFI.LibFunc 46)
  encodeM LF__atan = return (FFI.LibFunc 47)
  encodeM LF__atan2 = return (FFI.LibFunc 48)
  encodeM LF__atan2f = return (FFI.LibFunc 49)
  encodeM LF__atan2l = return (FFI.LibFunc 50)
  encodeM LF__atanf = return (FFI.LibFunc 51)
  encodeM LF__atanh = return (FFI.LibFunc 52)
  encodeM LF__atanhf = return (FFI.LibFunc 53)
  encodeM LF__atanhl = return (FFI.LibFunc 54)
  encodeM LF__atanl = return (FFI.LibFunc 55)
  encodeM LF__atof = return (FFI.LibFunc 56)
  encodeM LF__atoi = return (FFI.LibFunc 57)
  encodeM LF__atol = return (FFI.LibFunc 58)
  encodeM LF__atoll = return (FFI.LibFunc 59)
  encodeM LF__bcmp = return (FFI.LibFunc 60)
  encodeM LF__bcopy = return (FFI.LibFunc 61)
  encodeM LF__bzero = return (FFI.LibFunc 62)
  encodeM LF__calloc = return (FFI.LibFunc 63)
  encodeM LF__cbrt = return (FFI.LibFunc 64)
  encodeM LF__cbrtf = return (FFI.LibFunc 65)
  encodeM LF__cbrtl = return (FFI.LibFunc 66)
  encodeM LF__ceil = return (FFI.LibFunc 67)
  encodeM LF__ceilf = return (FFI.LibFunc 68)
  encodeM LF__ceill = return (FFI.LibFunc 69)
  encodeM LF__chmod = return (FFI.LibFunc 70)
  encodeM LF__chown = return (FFI.LibFunc 71)
  encodeM LF__clearerr = return (FFI.LibFunc 72)
  encodeM LF__closedir = return (FFI.LibFunc 73)
  encodeM LF__copysign = return (FFI.LibFunc 74)
  encodeM LF__copysignf = return (FFI.LibFunc 75)
  encodeM LF__copysignl = return (FFI.LibFunc 76)
  encodeM LF__cos = return (FFI.LibFunc 77)
  encodeM LF__cosf = return (FFI.LibFunc 78)
  encodeM LF__cosh = return (FFI.LibFunc 79)
  encodeM LF__coshf = return (FFI.LibFunc 80)
  encodeM LF__coshl = return (FFI.LibFunc 81)
  encodeM LF__cosl = return (FFI.LibFunc 82)
  encodeM LF__ctermid = return (FFI.LibFunc 83)
  encodeM LF__exp = return (FFI.LibFunc 84)
  encodeM LF__exp10 = return (FFI.LibFunc 85)
  encodeM LF__exp10f = return (FFI.LibFunc 86)
  encodeM LF__exp10l = return (FFI.LibFunc 87)
  encodeM LF__exp2 = return (FFI.LibFunc 88)
  encodeM LF__exp2f = return (FFI.LibFunc 89)
  encodeM LF__exp2l = return (FFI.LibFunc 90)
  encodeM LF__expf = return (FFI.LibFunc 91)
  encodeM LF__expl = return (FFI.LibFunc 92)
  encodeM LF__expm1 = return (FFI.LibFunc 93)
  encodeM LF__expm1f = return (FFI.LibFunc 94)
  encodeM LF__expm1l = return (FFI.LibFunc 95)
  encodeM LF__fabs = return (FFI.LibFunc 96)
  encodeM LF__fabsf = return (FFI.LibFunc 97)
  encodeM LF__fabsl = return (FFI.LibFunc 98)
  encodeM LF__fclose = return (FFI.LibFunc 99)
  encodeM LF__fdopen = return (FFI.LibFunc 100)
  encodeM LF__feof = return (FFI.LibFunc 101)
  encodeM LF__ferror = return (FFI.LibFunc 102)
  encodeM LF__fflush = return (FFI.LibFunc 103)
  encodeM LF__ffs = return (FFI.LibFunc 104)
  encodeM LF__ffsl = return (FFI.LibFunc 105)
  encodeM LF__ffsll = return (FFI.LibFunc 106)
  encodeM LF__fgetc = return (FFI.LibFunc 107)
  encodeM LF__fgetpos = return (FFI.LibFunc 108)
  encodeM LF__fgets = return (FFI.LibFunc 109)
  encodeM LF__fileno = return (FFI.LibFunc 110)
  encodeM LF__fiprintf = return (FFI.LibFunc 111)
  encodeM LF__flockfile = return (FFI.LibFunc 112)
  encodeM LF__floor = return (FFI.LibFunc 113)
  encodeM LF__floorf = return (FFI.LibFunc 114)
  encodeM LF__floorl = return (FFI.LibFunc 115)
  encodeM LF__fmax = return (FFI.LibFunc 116)
  encodeM LF__fmaxf = return (FFI.LibFunc 117)
  encodeM LF__fmaxl = return (FFI.LibFunc 118)
  encodeM LF__fmin = return (FFI.LibFunc 119)
  encodeM LF__fminf = return (FFI.LibFunc 120)
  encodeM LF__fminl = return (FFI.LibFunc 121)
  encodeM LF__fmod = return (FFI.LibFunc 122)
  encodeM LF__fmodf = return (FFI.LibFunc 123)
  encodeM LF__fmodl = return (FFI.LibFunc 124)
  encodeM LF__fopen = return (FFI.LibFunc 125)
  encodeM LF__fopen64 = return (FFI.LibFunc 126)
  encodeM LF__fprintf = return (FFI.LibFunc 127)
  encodeM LF__fputc = return (FFI.LibFunc 128)
  encodeM LF__fputs = return (FFI.LibFunc 129)
  encodeM LF__fread = return (FFI.LibFunc 130)
  encodeM LF__free = return (FFI.LibFunc 131)
  encodeM LF__frexp = return (FFI.LibFunc 132)
  encodeM LF__frexpf = return (FFI.LibFunc 133)
  encodeM LF__frexpl = return (FFI.LibFunc 134)
  encodeM LF__fscanf = return (FFI.LibFunc 135)
  encodeM LF__fseek = return (FFI.LibFunc 136)
  encodeM LF__fseeko = return (FFI.LibFunc 137)
  encodeM LF__fseeko64 = return (FFI.LibFunc 138)
  encodeM LF__fsetpos = return (FFI.LibFunc 139)
  encodeM LF__fstat = return (FFI.LibFunc 140)
  encodeM LF__fstat64 = return (FFI.LibFunc 141)
  encodeM LF__fstatvfs = return (FFI.LibFunc 142)
  encodeM LF__fstatvfs64 = return (FFI.LibFunc 143)
  encodeM LF__ftell = return (FFI.LibFunc 144)
  encodeM LF__ftello = return (FFI.LibFunc 145)
  encodeM LF__ftello64 = return (FFI.LibFunc 146)
  encodeM LF__ftrylockfile = return (FFI.LibFunc 147)
  encodeM LF__funlockfile = return (FFI.LibFunc 148)
  encodeM LF__fwrite = return (FFI.LibFunc 149)
  encodeM LF__getc = return (FFI.LibFunc 150)
  encodeM LF__getc_unlocked = return (FFI.LibFunc 151)
  encodeM LF__getchar = return (FFI.LibFunc 152)
  encodeM LF__getenv = return (FFI.LibFunc 153)
  encodeM LF__getitimer = return (FFI.LibFunc 154)
  encodeM LF__getlogin_r = return (FFI.LibFunc 155)
  encodeM LF__getpwnam = return (FFI.LibFunc 156)
  encodeM LF__gets = return (FFI.LibFunc 157)
  encodeM LF__gettimeofday = return (FFI.LibFunc 158)
  encodeM LF__htonl = return (FFI.LibFunc 159)
  encodeM LF__htons = return (FFI.LibFunc 160)
  encodeM LF__iprintf = return (FFI.LibFunc 161)
  encodeM LF__isascii = return (FFI.LibFunc 162)
  encodeM LF__isdigit = return (FFI.LibFunc 163)
  encodeM LF__labs = return (FFI.LibFunc 164)
  encodeM LF__lchown = return (FFI.LibFunc 165)
  encodeM LF__ldexp = return (FFI.LibFunc 166)
  encodeM LF__ldexpf = return (FFI.LibFunc 167)
  encodeM LF__ldexpl = return (FFI.LibFunc 168)
  encodeM LF__llabs = return (FFI.LibFunc 169)
  encodeM LF__log = return (FFI.LibFunc 170)
  encodeM LF__log10 = return (FFI.LibFunc 171)
  encodeM LF__log10f = return (FFI.LibFunc 172)
  encodeM LF__log10l = return (FFI.LibFunc 173)
  encodeM LF__log1p = return (FFI.LibFunc 174)
  encodeM LF__log1pf = return (FFI.LibFunc 175)
  encodeM LF__log1pl = return (FFI.LibFunc 176)
  encodeM LF__log2 = return (FFI.LibFunc 177)
  encodeM LF__log2f = return (FFI.LibFunc 178)
  encodeM LF__log2l = return (FFI.LibFunc 179)
  encodeM LF__logb = return (FFI.LibFunc 180)
  encodeM LF__logbf = return (FFI.LibFunc 181)
  encodeM LF__logbl = return (FFI.LibFunc 182)
  encodeM LF__logf = return (FFI.LibFunc 183)
  encodeM LF__logl = return (FFI.LibFunc 184)
  encodeM LF__lstat = return (FFI.LibFunc 185)
  encodeM LF__lstat64 = return (FFI.LibFunc 186)
  encodeM LF__malloc = return (FFI.LibFunc 187)
  encodeM LF__memalign = return (FFI.LibFunc 188)
  encodeM LF__memccpy = return (FFI.LibFunc 189)
  encodeM LF__memchr = return (FFI.LibFunc 190)
  encodeM LF__memcmp = return (FFI.LibFunc 191)
  encodeM LF__memcpy = return (FFI.LibFunc 192)
  encodeM LF__memmove = return (FFI.LibFunc 193)
  encodeM LF__memrchr = return (FFI.LibFunc 194)
  encodeM LF__memset = return (FFI.LibFunc 195)
  encodeM LF__memset_pattern16 = return (FFI.LibFunc 196)
  encodeM LF__mkdir = return (FFI.LibFunc 197)
  encodeM LF__mktime = return (FFI.LibFunc 198)
  encodeM LF__modf = return (FFI.LibFunc 199)
  encodeM LF__modff = return (FFI.LibFunc 200)
  encodeM LF__modfl = return (FFI.LibFunc 201)
  encodeM LF__nearbyint = return (FFI.LibFunc 202)
  encodeM LF__nearbyintf = return (FFI.LibFunc 203)
  encodeM LF__nearbyintl = return (FFI.LibFunc 204)
  encodeM LF__ntohl = return (FFI.LibFunc 205)
  encodeM LF__ntohs = return (FFI.LibFunc 206)
  encodeM LF__open = return (FFI.LibFunc 207)
  encodeM LF__open64 = return (FFI.LibFunc 208)
  encodeM LF__opendir = return (FFI.LibFunc 209)
  encodeM LF__pclose = return (FFI.LibFunc 210)
  encodeM LF__perror = return (FFI.LibFunc 211)
  encodeM LF__popen = return (FFI.LibFunc 212)
  encodeM LF__posix_memalign = return (FFI.LibFunc 213)
  encodeM LF__pow = return (FFI.LibFunc 214)
  encodeM LF__powf = return (FFI.LibFunc 215)
  encodeM LF__powl = return (FFI.LibFunc 216)
  encodeM LF__pread = return (FFI.LibFunc 217)
  encodeM LF__printf = return (FFI.LibFunc 218)
  encodeM LF__putc = return (FFI.LibFunc 219)
  encodeM LF__putchar = return (FFI.LibFunc 220)
  encodeM LF__puts = return (FFI.LibFunc 221)
  encodeM LF__pwrite = return (FFI.LibFunc 222)
  encodeM LF__qsort = return (FFI.LibFunc 223)
  encodeM LF__read = return (FFI.LibFunc 224)
  encodeM LF__readlink = return (FFI.LibFunc 225)
  encodeM LF__realloc = return (FFI.LibFunc 226)
  encodeM LF__reallocf = return (FFI.LibFunc 227)
  encodeM LF__realpath = return (FFI.LibFunc 228)
  encodeM LF__remove = return (FFI.LibFunc 229)
  encodeM LF__rename = return (FFI.LibFunc 230)
  encodeM LF__rewind = return (FFI.LibFunc 231)
  encodeM LF__rint = return (FFI.LibFunc 232)
  encodeM LF__rintf = return (FFI.LibFunc 233)
  encodeM LF__rintl = return (FFI.LibFunc 234)
  encodeM LF__rmdir = return (FFI.LibFunc 235)
  encodeM LF__round = return (FFI.LibFunc 236)
  encodeM LF__roundf = return (FFI.LibFunc 237)
  encodeM LF__roundl = return (FFI.LibFunc 238)
  encodeM LF__scanf = return (FFI.LibFunc 239)
  encodeM LF__setbuf = return (FFI.LibFunc 240)
  encodeM LF__setitimer = return (FFI.LibFunc 241)
  encodeM LF__setvbuf = return (FFI.LibFunc 242)
  encodeM LF__sin = return (FFI.LibFunc 243)
  encodeM LF__sinf = return (FFI.LibFunc 244)
  encodeM LF__sinh = return (FFI.LibFunc 245)
  encodeM LF__sinhf = return (FFI.LibFunc 246)
  encodeM LF__sinhl = return (FFI.LibFunc 247)
  encodeM LF__sinl = return (FFI.LibFunc 248)
  encodeM LF__siprintf = return (FFI.LibFunc 249)
  encodeM LF__snprintf = return (FFI.LibFunc 250)
  encodeM LF__sprintf = return (FFI.LibFunc 251)
  encodeM LF__sqrt = return (FFI.LibFunc 252)
  encodeM LF__sqrtf = return (FFI.LibFunc 253)
  encodeM LF__sqrtl = return (FFI.LibFunc 254)
  encodeM LF__sscanf = return (FFI.LibFunc 255)
  encodeM LF__stat = return (FFI.LibFunc 256)
  encodeM LF__stat64 = return (FFI.LibFunc 257)
  encodeM LF__statvfs = return (FFI.LibFunc 258)
  encodeM LF__statvfs64 = return (FFI.LibFunc 259)
  encodeM LF__stpcpy = return (FFI.LibFunc 260)
  encodeM LF__stpncpy = return (FFI.LibFunc 261)
  encodeM LF__strcasecmp = return (FFI.LibFunc 262)
  encodeM LF__strcat = return (FFI.LibFunc 263)
  encodeM LF__strchr = return (FFI.LibFunc 264)
  encodeM LF__strcmp = return (FFI.LibFunc 265)
  encodeM LF__strcoll = return (FFI.LibFunc 266)
  encodeM LF__strcpy = return (FFI.LibFunc 267)
  encodeM LF__strcspn = return (FFI.LibFunc 268)
  encodeM LF__strdup = return (FFI.LibFunc 269)
  encodeM LF__strlen = return (FFI.LibFunc 270)
  encodeM LF__strncasecmp = return (FFI.LibFunc 271)
  encodeM LF__strncat = return (FFI.LibFunc 272)
  encodeM LF__strncmp = return (FFI.LibFunc 273)
  encodeM LF__strncpy = return (FFI.LibFunc 274)
  encodeM LF__strndup = return (FFI.LibFunc 275)
  encodeM LF__strnlen = return (FFI.LibFunc 276)
  encodeM LF__strpbrk = return (FFI.LibFunc 277)
  encodeM LF__strrchr = return (FFI.LibFunc 278)
  encodeM LF__strspn = return (FFI.LibFunc 279)
  encodeM LF__strstr = return (FFI.LibFunc 280)
  encodeM LF__strtod = return (FFI.LibFunc 281)
  encodeM LF__strtof = return (FFI.LibFunc 282)
  encodeM LF__strtok = return (FFI.LibFunc 283)
  encodeM LF__strtok_r = return (FFI.LibFunc 284)
  encodeM LF__strtol = return (FFI.LibFunc 285)
  encodeM LF__strtold = return (FFI.LibFunc 286)
  encodeM LF__strtoll = return (FFI.LibFunc 287)
  encodeM LF__strtoul = return (FFI.LibFunc 288)
  encodeM LF__strtoull = return (FFI.LibFunc 289)
  encodeM LF__strxfrm = return (FFI.LibFunc 290)
  encodeM LF__system = return (FFI.LibFunc 291)
  encodeM LF__tan = return (FFI.LibFunc 292)
  encodeM LF__tanf = return (FFI.LibFunc 293)
  encodeM LF__tanh = return (FFI.LibFunc 294)
  encodeM LF__tanhf = return (FFI.LibFunc 295)
  encodeM LF__tanhl = return (FFI.LibFunc 296)
  encodeM LF__tanl = return (FFI.LibFunc 297)
  encodeM LF__times = return (FFI.LibFunc 298)
  encodeM LF__tmpfile = return (FFI.LibFunc 299)
  encodeM LF__tmpfile64 = return (FFI.LibFunc 300)
  encodeM LF__toascii = return (FFI.LibFunc 301)
  encodeM LF__trunc = return (FFI.LibFunc 302)
  encodeM LF__truncf = return (FFI.LibFunc 303)
  encodeM LF__truncl = return (FFI.LibFunc 304)
  encodeM LF__uname = return (FFI.LibFunc 305)
  encodeM LF__ungetc = return (FFI.LibFunc 306)
  encodeM LF__unlink = return (FFI.LibFunc 307)
  encodeM LF__unsetenv = return (FFI.LibFunc 308)
  encodeM LF__utime = return (FFI.LibFunc 309)
  encodeM LF__utimes = return (FFI.LibFunc 310)
  encodeM LF__valloc = return (FFI.LibFunc 311)
  encodeM LF__vfprintf = return (FFI.LibFunc 312)
  encodeM LF__vfscanf = return (FFI.LibFunc 313)
  encodeM LF__vprintf = return (FFI.LibFunc 314)
  encodeM LF__vscanf = return (FFI.LibFunc 315)
  encodeM LF__vsnprintf = return (FFI.LibFunc 316)
  encodeM LF__vsprintf = return (FFI.LibFunc 317)
  encodeM LF__vsscanf = return (FFI.LibFunc 318)
  encodeM LF__write = return (FFI.LibFunc 319)

instance Monad m => DecodeM m LibraryFunction FFI.LibFunc where
  decodeM (FFI.LibFunc 0) = return LF__under_IO_getc 
  decodeM (FFI.LibFunc 1) = return LF__under_IO_putc 
  decodeM (FFI.LibFunc 2) = return LF__ZdaPv 
  decodeM (FFI.LibFunc 3) = return LF__ZdaPvRKSt9nothrow_t 
  decodeM (FFI.LibFunc 4) = return LF__ZdlPv 
  decodeM (FFI.LibFunc 5) = return LF__ZdlPvRKSt9nothrow_t 
  decodeM (FFI.LibFunc 6) = return LF__Znaj 
  decodeM (FFI.LibFunc 7) = return LF__ZnajRKSt9nothrow_t 
  decodeM (FFI.LibFunc 8) = return LF__Znam 
  decodeM (FFI.LibFunc 9) = return LF__ZnamRKSt9nothrow_t 
  decodeM (FFI.LibFunc 10) = return LF__Znwj 
  decodeM (FFI.LibFunc 11) = return LF__ZnwjRKSt9nothrow_t 
  decodeM (FFI.LibFunc 12) = return LF__Znwm 
  decodeM (FFI.LibFunc 13) = return LF__ZnwmRKSt9nothrow_t 
  decodeM (FFI.LibFunc 14) = return LF__cospi 
  decodeM (FFI.LibFunc 15) = return LF__cospif 
  decodeM (FFI.LibFunc 16) = return LF__cxa_atexit 
  decodeM (FFI.LibFunc 17) = return LF__cxa_guard_abort 
  decodeM (FFI.LibFunc 18) = return LF__cxa_guard_acquire 
  decodeM (FFI.LibFunc 19) = return LF__cxa_guard_release 
  decodeM (FFI.LibFunc 20) = return LF__dunder_isoc99_scanf 
  decodeM (FFI.LibFunc 21) = return LF__dunder_isoc99_sscanf 
  decodeM (FFI.LibFunc 22) = return LF__memcpy_chk 
  decodeM (FFI.LibFunc 23) = return LF__sincospi_stret 
  decodeM (FFI.LibFunc 24) = return LF__sincospif_stret 
  decodeM (FFI.LibFunc 25) = return LF__sinpi 
  decodeM (FFI.LibFunc 26) = return LF__sinpif 
  decodeM (FFI.LibFunc 27) = return LF__sqrt_finite 
  decodeM (FFI.LibFunc 28) = return LF__sqrtf_finite 
  decodeM (FFI.LibFunc 29) = return LF__sqrtl_finite 
  decodeM (FFI.LibFunc 30) = return LF__dunder_strdup 
  decodeM (FFI.LibFunc 31) = return LF__dunder_strndup 
  decodeM (FFI.LibFunc 32) = return LF__dunder_strtok_r 
  decodeM (FFI.LibFunc 33) = return LF__abs 
  decodeM (FFI.LibFunc 34) = return LF__access 
  decodeM (FFI.LibFunc 35) = return LF__acos 
  decodeM (FFI.LibFunc 36) = return LF__acosf 
  decodeM (FFI.LibFunc 37) = return LF__acosh 
  decodeM (FFI.LibFunc 38) = return LF__acoshf 
  decodeM (FFI.LibFunc 39) = return LF__acoshl 
  decodeM (FFI.LibFunc 40) = return LF__acosl 
  decodeM (FFI.LibFunc 41) = return LF__asin 
  decodeM (FFI.LibFunc 42) = return LF__asinf 
  decodeM (FFI.LibFunc 43) = return LF__asinh 
  decodeM (FFI.LibFunc 44) = return LF__asinhf 
  decodeM (FFI.LibFunc 45) = return LF__asinhl 
  decodeM (FFI.LibFunc 46) = return LF__asinl 
  decodeM (FFI.LibFunc 47) = return LF__atan 
  decodeM (FFI.LibFunc 48) = return LF__atan2 
  decodeM (FFI.LibFunc 49) = return LF__atan2f 
  decodeM (FFI.LibFunc 50) = return LF__atan2l 
  decodeM (FFI.LibFunc 51) = return LF__atanf 
  decodeM (FFI.LibFunc 52) = return LF__atanh 
  decodeM (FFI.LibFunc 53) = return LF__atanhf 
  decodeM (FFI.LibFunc 54) = return LF__atanhl 
  decodeM (FFI.LibFunc 55) = return LF__atanl 
  decodeM (FFI.LibFunc 56) = return LF__atof 
  decodeM (FFI.LibFunc 57) = return LF__atoi 
  decodeM (FFI.LibFunc 58) = return LF__atol 
  decodeM (FFI.LibFunc 59) = return LF__atoll 
  decodeM (FFI.LibFunc 60) = return LF__bcmp 
  decodeM (FFI.LibFunc 61) = return LF__bcopy 
  decodeM (FFI.LibFunc 62) = return LF__bzero 
  decodeM (FFI.LibFunc 63) = return LF__calloc 
  decodeM (FFI.LibFunc 64) = return LF__cbrt 
  decodeM (FFI.LibFunc 65) = return LF__cbrtf 
  decodeM (FFI.LibFunc 66) = return LF__cbrtl 
  decodeM (FFI.LibFunc 67) = return LF__ceil 
  decodeM (FFI.LibFunc 68) = return LF__ceilf 
  decodeM (FFI.LibFunc 69) = return LF__ceill 
  decodeM (FFI.LibFunc 70) = return LF__chmod 
  decodeM (FFI.LibFunc 71) = return LF__chown 
  decodeM (FFI.LibFunc 72) = return LF__clearerr 
  decodeM (FFI.LibFunc 73) = return LF__closedir 
  decodeM (FFI.LibFunc 74) = return LF__copysign 
  decodeM (FFI.LibFunc 75) = return LF__copysignf 
  decodeM (FFI.LibFunc 76) = return LF__copysignl 
  decodeM (FFI.LibFunc 77) = return LF__cos 
  decodeM (FFI.LibFunc 78) = return LF__cosf 
  decodeM (FFI.LibFunc 79) = return LF__cosh 
  decodeM (FFI.LibFunc 80) = return LF__coshf 
  decodeM (FFI.LibFunc 81) = return LF__coshl 
  decodeM (FFI.LibFunc 82) = return LF__cosl 
  decodeM (FFI.LibFunc 83) = return LF__ctermid 
  decodeM (FFI.LibFunc 84) = return LF__exp 
  decodeM (FFI.LibFunc 85) = return LF__exp10 
  decodeM (FFI.LibFunc 86) = return LF__exp10f 
  decodeM (FFI.LibFunc 87) = return LF__exp10l 
  decodeM (FFI.LibFunc 88) = return LF__exp2 
  decodeM (FFI.LibFunc 89) = return LF__exp2f 
  decodeM (FFI.LibFunc 90) = return LF__exp2l 
  decodeM (FFI.LibFunc 91) = return LF__expf 
  decodeM (FFI.LibFunc 92) = return LF__expl 
  decodeM (FFI.LibFunc 93) = return LF__expm1 
  decodeM (FFI.LibFunc 94) = return LF__expm1f 
  decodeM (FFI.LibFunc 95) = return LF__expm1l 
  decodeM (FFI.LibFunc 96) = return LF__fabs 
  decodeM (FFI.LibFunc 97) = return LF__fabsf 
  decodeM (FFI.LibFunc 98) = return LF__fabsl 
  decodeM (FFI.LibFunc 99) = return LF__fclose 
  decodeM (FFI.LibFunc 100) = return LF__fdopen 
  decodeM (FFI.LibFunc 101) = return LF__feof 
  decodeM (FFI.LibFunc 102) = return LF__ferror 
  decodeM (FFI.LibFunc 103) = return LF__fflush 
  decodeM (FFI.LibFunc 104) = return LF__ffs 
  decodeM (FFI.LibFunc 105) = return LF__ffsl 
  decodeM (FFI.LibFunc 106) = return LF__ffsll 
  decodeM (FFI.LibFunc 107) = return LF__fgetc 
  decodeM (FFI.LibFunc 108) = return LF__fgetpos 
  decodeM (FFI.LibFunc 109) = return LF__fgets 
  decodeM (FFI.LibFunc 110) = return LF__fileno 
  decodeM (FFI.LibFunc 111) = return LF__fiprintf 
  decodeM (FFI.LibFunc 112) = return LF__flockfile 
  decodeM (FFI.LibFunc 113) = return LF__floor 
  decodeM (FFI.LibFunc 114) = return LF__floorf 
  decodeM (FFI.LibFunc 115) = return LF__floorl 
  decodeM (FFI.LibFunc 116) = return LF__fmax 
  decodeM (FFI.LibFunc 117) = return LF__fmaxf 
  decodeM (FFI.LibFunc 118) = return LF__fmaxl 
  decodeM (FFI.LibFunc 119) = return LF__fmin 
  decodeM (FFI.LibFunc 120) = return LF__fminf 
  decodeM (FFI.LibFunc 121) = return LF__fminl 
  decodeM (FFI.LibFunc 122) = return LF__fmod 
  decodeM (FFI.LibFunc 123) = return LF__fmodf 
  decodeM (FFI.LibFunc 124) = return LF__fmodl 
  decodeM (FFI.LibFunc 125) = return LF__fopen 
  decodeM (FFI.LibFunc 126) = return LF__fopen64 
  decodeM (FFI.LibFunc 127) = return LF__fprintf 
  decodeM (FFI.LibFunc 128) = return LF__fputc 
  decodeM (FFI.LibFunc 129) = return LF__fputs 
  decodeM (FFI.LibFunc 130) = return LF__fread 
  decodeM (FFI.LibFunc 131) = return LF__free 
  decodeM (FFI.LibFunc 132) = return LF__frexp 
  decodeM (FFI.LibFunc 133) = return LF__frexpf 
  decodeM (FFI.LibFunc 134) = return LF__frexpl 
  decodeM (FFI.LibFunc 135) = return LF__fscanf 
  decodeM (FFI.LibFunc 136) = return LF__fseek 
  decodeM (FFI.LibFunc 137) = return LF__fseeko 
  decodeM (FFI.LibFunc 138) = return LF__fseeko64 
  decodeM (FFI.LibFunc 139) = return LF__fsetpos 
  decodeM (FFI.LibFunc 140) = return LF__fstat 
  decodeM (FFI.LibFunc 141) = return LF__fstat64 
  decodeM (FFI.LibFunc 142) = return LF__fstatvfs 
  decodeM (FFI.LibFunc 143) = return LF__fstatvfs64 
  decodeM (FFI.LibFunc 144) = return LF__ftell 
  decodeM (FFI.LibFunc 145) = return LF__ftello 
  decodeM (FFI.LibFunc 146) = return LF__ftello64 
  decodeM (FFI.LibFunc 147) = return LF__ftrylockfile 
  decodeM (FFI.LibFunc 148) = return LF__funlockfile 
  decodeM (FFI.LibFunc 149) = return LF__fwrite 
  decodeM (FFI.LibFunc 150) = return LF__getc 
  decodeM (FFI.LibFunc 151) = return LF__getc_unlocked 
  decodeM (FFI.LibFunc 152) = return LF__getchar 
  decodeM (FFI.LibFunc 153) = return LF__getenv 
  decodeM (FFI.LibFunc 154) = return LF__getitimer 
  decodeM (FFI.LibFunc 155) = return LF__getlogin_r 
  decodeM (FFI.LibFunc 156) = return LF__getpwnam 
  decodeM (FFI.LibFunc 157) = return LF__gets 
  decodeM (FFI.LibFunc 158) = return LF__gettimeofday 
  decodeM (FFI.LibFunc 159) = return LF__htonl 
  decodeM (FFI.LibFunc 160) = return LF__htons 
  decodeM (FFI.LibFunc 161) = return LF__iprintf 
  decodeM (FFI.LibFunc 162) = return LF__isascii 
  decodeM (FFI.LibFunc 163) = return LF__isdigit 
  decodeM (FFI.LibFunc 164) = return LF__labs 
  decodeM (FFI.LibFunc 165) = return LF__lchown 
  decodeM (FFI.LibFunc 166) = return LF__ldexp 
  decodeM (FFI.LibFunc 167) = return LF__ldexpf 
  decodeM (FFI.LibFunc 168) = return LF__ldexpl 
  decodeM (FFI.LibFunc 169) = return LF__llabs 
  decodeM (FFI.LibFunc 170) = return LF__log 
  decodeM (FFI.LibFunc 171) = return LF__log10 
  decodeM (FFI.LibFunc 172) = return LF__log10f 
  decodeM (FFI.LibFunc 173) = return LF__log10l 
  decodeM (FFI.LibFunc 174) = return LF__log1p 
  decodeM (FFI.LibFunc 175) = return LF__log1pf 
  decodeM (FFI.LibFunc 176) = return LF__log1pl 
  decodeM (FFI.LibFunc 177) = return LF__log2 
  decodeM (FFI.LibFunc 178) = return LF__log2f 
  decodeM (FFI.LibFunc 179) = return LF__log2l 
  decodeM (FFI.LibFunc 180) = return LF__logb 
  decodeM (FFI.LibFunc 181) = return LF__logbf 
  decodeM (FFI.LibFunc 182) = return LF__logbl 
  decodeM (FFI.LibFunc 183) = return LF__logf 
  decodeM (FFI.LibFunc 184) = return LF__logl 
  decodeM (FFI.LibFunc 185) = return LF__lstat 
  decodeM (FFI.LibFunc 186) = return LF__lstat64 
  decodeM (FFI.LibFunc 187) = return LF__malloc 
  decodeM (FFI.LibFunc 188) = return LF__memalign 
  decodeM (FFI.LibFunc 189) = return LF__memccpy 
  decodeM (FFI.LibFunc 190) = return LF__memchr 
  decodeM (FFI.LibFunc 191) = return LF__memcmp 
  decodeM (FFI.LibFunc 192) = return LF__memcpy 
  decodeM (FFI.LibFunc 193) = return LF__memmove 
  decodeM (FFI.LibFunc 194) = return LF__memrchr 
  decodeM (FFI.LibFunc 195) = return LF__memset 
  decodeM (FFI.LibFunc 196) = return LF__memset_pattern16 
  decodeM (FFI.LibFunc 197) = return LF__mkdir 
  decodeM (FFI.LibFunc 198) = return LF__mktime 
  decodeM (FFI.LibFunc 199) = return LF__modf 
  decodeM (FFI.LibFunc 200) = return LF__modff 
  decodeM (FFI.LibFunc 201) = return LF__modfl 
  decodeM (FFI.LibFunc 202) = return LF__nearbyint 
  decodeM (FFI.LibFunc 203) = return LF__nearbyintf 
  decodeM (FFI.LibFunc 204) = return LF__nearbyintl 
  decodeM (FFI.LibFunc 205) = return LF__ntohl 
  decodeM (FFI.LibFunc 206) = return LF__ntohs 
  decodeM (FFI.LibFunc 207) = return LF__open 
  decodeM (FFI.LibFunc 208) = return LF__open64 
  decodeM (FFI.LibFunc 209) = return LF__opendir 
  decodeM (FFI.LibFunc 210) = return LF__pclose 
  decodeM (FFI.LibFunc 211) = return LF__perror 
  decodeM (FFI.LibFunc 212) = return LF__popen 
  decodeM (FFI.LibFunc 213) = return LF__posix_memalign 
  decodeM (FFI.LibFunc 214) = return LF__pow 
  decodeM (FFI.LibFunc 215) = return LF__powf 
  decodeM (FFI.LibFunc 216) = return LF__powl 
  decodeM (FFI.LibFunc 217) = return LF__pread 
  decodeM (FFI.LibFunc 218) = return LF__printf 
  decodeM (FFI.LibFunc 219) = return LF__putc 
  decodeM (FFI.LibFunc 220) = return LF__putchar 
  decodeM (FFI.LibFunc 221) = return LF__puts 
  decodeM (FFI.LibFunc 222) = return LF__pwrite 
  decodeM (FFI.LibFunc 223) = return LF__qsort 
  decodeM (FFI.LibFunc 224) = return LF__read 
  decodeM (FFI.LibFunc 225) = return LF__readlink 
  decodeM (FFI.LibFunc 226) = return LF__realloc 
  decodeM (FFI.LibFunc 227) = return LF__reallocf 
  decodeM (FFI.LibFunc 228) = return LF__realpath 
  decodeM (FFI.LibFunc 229) = return LF__remove 
  decodeM (FFI.LibFunc 230) = return LF__rename 
  decodeM (FFI.LibFunc 231) = return LF__rewind 
  decodeM (FFI.LibFunc 232) = return LF__rint 
  decodeM (FFI.LibFunc 233) = return LF__rintf 
  decodeM (FFI.LibFunc 234) = return LF__rintl 
  decodeM (FFI.LibFunc 235) = return LF__rmdir 
  decodeM (FFI.LibFunc 236) = return LF__round 
  decodeM (FFI.LibFunc 237) = return LF__roundf 
  decodeM (FFI.LibFunc 238) = return LF__roundl 
  decodeM (FFI.LibFunc 239) = return LF__scanf 
  decodeM (FFI.LibFunc 240) = return LF__setbuf 
  decodeM (FFI.LibFunc 241) = return LF__setitimer 
  decodeM (FFI.LibFunc 242) = return LF__setvbuf 
  decodeM (FFI.LibFunc 243) = return LF__sin 
  decodeM (FFI.LibFunc 244) = return LF__sinf 
  decodeM (FFI.LibFunc 245) = return LF__sinh 
  decodeM (FFI.LibFunc 246) = return LF__sinhf 
  decodeM (FFI.LibFunc 247) = return LF__sinhl 
  decodeM (FFI.LibFunc 248) = return LF__sinl 
  decodeM (FFI.LibFunc 249) = return LF__siprintf 
  decodeM (FFI.LibFunc 250) = return LF__snprintf 
  decodeM (FFI.LibFunc 251) = return LF__sprintf 
  decodeM (FFI.LibFunc 252) = return LF__sqrt 
  decodeM (FFI.LibFunc 253) = return LF__sqrtf 
  decodeM (FFI.LibFunc 254) = return LF__sqrtl 
  decodeM (FFI.LibFunc 255) = return LF__sscanf 
  decodeM (FFI.LibFunc 256) = return LF__stat 
  decodeM (FFI.LibFunc 257) = return LF__stat64 
  decodeM (FFI.LibFunc 258) = return LF__statvfs 
  decodeM (FFI.LibFunc 259) = return LF__statvfs64 
  decodeM (FFI.LibFunc 260) = return LF__stpcpy 
  decodeM (FFI.LibFunc 261) = return LF__stpncpy 
  decodeM (FFI.LibFunc 262) = return LF__strcasecmp 
  decodeM (FFI.LibFunc 263) = return LF__strcat 
  decodeM (FFI.LibFunc 264) = return LF__strchr 
  decodeM (FFI.LibFunc 265) = return LF__strcmp 
  decodeM (FFI.LibFunc 266) = return LF__strcoll 
  decodeM (FFI.LibFunc 267) = return LF__strcpy 
  decodeM (FFI.LibFunc 268) = return LF__strcspn 
  decodeM (FFI.LibFunc 269) = return LF__strdup 
  decodeM (FFI.LibFunc 270) = return LF__strlen 
  decodeM (FFI.LibFunc 271) = return LF__strncasecmp 
  decodeM (FFI.LibFunc 272) = return LF__strncat 
  decodeM (FFI.LibFunc 273) = return LF__strncmp 
  decodeM (FFI.LibFunc 274) = return LF__strncpy 
  decodeM (FFI.LibFunc 275) = return LF__strndup 
  decodeM (FFI.LibFunc 276) = return LF__strnlen 
  decodeM (FFI.LibFunc 277) = return LF__strpbrk 
  decodeM (FFI.LibFunc 278) = return LF__strrchr 
  decodeM (FFI.LibFunc 279) = return LF__strspn 
  decodeM (FFI.LibFunc 280) = return LF__strstr 
  decodeM (FFI.LibFunc 281) = return LF__strtod 
  decodeM (FFI.LibFunc 282) = return LF__strtof 
  decodeM (FFI.LibFunc 283) = return LF__strtok 
  decodeM (FFI.LibFunc 284) = return LF__strtok_r 
  decodeM (FFI.LibFunc 285) = return LF__strtol 
  decodeM (FFI.LibFunc 286) = return LF__strtold 
  decodeM (FFI.LibFunc 287) = return LF__strtoll 
  decodeM (FFI.LibFunc 288) = return LF__strtoul 
  decodeM (FFI.LibFunc 289) = return LF__strtoull 
  decodeM (FFI.LibFunc 290) = return LF__strxfrm 
  decodeM (FFI.LibFunc 291) = return LF__system 
  decodeM (FFI.LibFunc 292) = return LF__tan 
  decodeM (FFI.LibFunc 293) = return LF__tanf 
  decodeM (FFI.LibFunc 294) = return LF__tanh 
  decodeM (FFI.LibFunc 295) = return LF__tanhf 
  decodeM (FFI.LibFunc 296) = return LF__tanhl 
  decodeM (FFI.LibFunc 297) = return LF__tanl 
  decodeM (FFI.LibFunc 298) = return LF__times 
  decodeM (FFI.LibFunc 299) = return LF__tmpfile 
  decodeM (FFI.LibFunc 300) = return LF__tmpfile64 
  decodeM (FFI.LibFunc 301) = return LF__toascii 
  decodeM (FFI.LibFunc 302) = return LF__trunc 
  decodeM (FFI.LibFunc 303) = return LF__truncf 
  decodeM (FFI.LibFunc 304) = return LF__truncl 
  decodeM (FFI.LibFunc 305) = return LF__uname 
  decodeM (FFI.LibFunc 306) = return LF__ungetc 
  decodeM (FFI.LibFunc 307) = return LF__unlink 
  decodeM (FFI.LibFunc 308) = return LF__unsetenv 
  decodeM (FFI.LibFunc 309) = return LF__utime 
  decodeM (FFI.LibFunc 310) = return LF__utimes 
  decodeM (FFI.LibFunc 311) = return LF__valloc 
  decodeM (FFI.LibFunc 312) = return LF__vfprintf 
  decodeM (FFI.LibFunc 313) = return LF__vfscanf 
  decodeM (FFI.LibFunc 314) = return LF__vprintf 
  decodeM (FFI.LibFunc 315) = return LF__vscanf 
  decodeM (FFI.LibFunc 316) = return LF__vsnprintf 
  decodeM (FFI.LibFunc 317) = return LF__vsprintf 
  decodeM (FFI.LibFunc 318) = return LF__vsscanf 
  decodeM (FFI.LibFunc 319) = return LF__write 