From: mmarion@qualcomm.com
Subject: Re: [announce] autofsng 0.3.1
Date: Mon, 6 Dec 2004 17:33:41 -0800 (PST)
Message-ID: <200412070133.iB71Xf3M006262@cornholio.qualcomm.com>
References: <41A29809.9090707@sun.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <41A29809.9090707@sun.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael.Waychison@sun.com
Cc: autofs@linux.kernel.org

On 22 Nov, Mike Waychison wrote:

> I'm pleased to announce the release of AutofsNG 0.3.1.

Has anyone successfully built on an amd64 host?

On a 64bit, sles9 host, I get:

make[1]: Entering directory
`/local/mnt/workspace/builds/autofsng-0.3.1/modules'
gcc -shared -O3 -fomit-frame-pointer -Wall -I../include -fpic
-DAUTOFS_LIB_DIR=\"/lib/autofsng\" -o map_hosts.so map_hosts.c -lrpcsvc
/usr/lib64/gcc-lib/x86_64-suse-linux/3.3.3/../../../../x86_64-suse-linux/bin/ld:
/usr/lib64/gcc-lib/x86_64-suse-linux/3.3.3/../../../../lib64/librpcsvc.a(xmount.o):
relocation R_X86_64_32 can not be used when making a shared object; recompile
with -fPIC
/usr/lib64/gcc-lib/x86_64-suse-linux/3.3.3/../../../../lib64/librpcsvc.a:
could not read symbols: Bad value
collect2: ld returned 1 exit status
make[1]: *** [map_hosts.so] Error 1

Tried changing flags in Makefile from -fpic to -fPIC and it didn't help.

Compile works fine on a i686 Suse 9.2 install.
 
-- 
Mike Marion-Unix SysAdmin/Staff Engineer-http://www.qualcomm.com
Bob: "Ok, I'm goin'... but a swift kick in the ass isn't the solution to
everything you know."
Red: "I gotta disagree with you there Bob!" -- That 70's show
