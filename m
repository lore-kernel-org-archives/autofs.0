From: Chris Quenelle <chris.quenelle@oracle.com>
Subject: Re: two /net paths to the same local mount?
Date: Wed, 23 Jun 2010 11:32:24 -0700
Message-ID: <4C225338.8070008@oracle.com>
References: <4C1FBABF.5060207@oracle.com>
	<35D166B0274C8DB77A6BE435@[192.168.1.100]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <35D166B0274C8DB77A6BE435@[192.168.1.100]>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Michael Loftis <mloftis@wgops.com>, autofs@linux.kernel.org

Thanks for your time guys!

It turns out it's not a general bug.  I was just applying
a pessimistic interpretation without checking.

After more testing, it turns out it's just problem
on one machine, for two mount points under one
host alias.

I'm interested in knowing more about how I could
debug the situation without just rebooting and
hoping it doesn't happen again.

Here's my scenario:

I have three exported filesystems.
I can use three host aliases to refer to my own machine.
(carabas, carabas.sfbay, carabas.sfbay.sun.com)

/etc/hosts says:
[IP addr]     carabas.sfbay.sun.com carabas


All filesystems work under all /net/foo aliases
except two of them hang when accessed via one
of the host aliases.

% showmount -e localhost
Export list for localhost:
/export/home3 *
/export/home2 *
/export/home1 *


% df -kl
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/sda2             69575344   3408900  66166444   5% /
udev                   8222568       148   8222420   1% /dev
/dev/sdb1             71671728  26507132  45164596  37% /export/home1
/dev/sdc1             71671728   8545196  63126532  12% /export/home2
/dev/sdd1             71671728   5375672  66296056   8% /export/home3
/export/home1         71671728  26507128  45164600  37% /net/carabas/export/home1
/export/home2         71671728   8545196  63126532  12% /net/carabas.sfbay/export/home2
/export/home1         71671728  26507128  45164600  37% /net/carabas.sfbay/export/home1
/export/home3         71671728   5375672  66296056   8% /net/carabas.sfbay/export/home3
/export/home1         71671728  26507128  45164600  37% /net/carabas.sfbay.sun.com/export/home1
/export/home2         71671728   8545196  63126532  12% /net/carabas.sfbay.sun.com/export/home2
/export/home3         71671728   5375672  66296056   8% /net/carabas.sfbay.sun.com/export/home3


% strace ls /net/carabas/export/home2
...
...
mmap(NULL, 217016, PROT_READ, MAP_SHARED, 4, 0) = 0x2b2388370000
close(4)                                = 0
close(3)                                = 0
open("/net/carabas/export/home2", O_RDONLY|O_NONBLOCK|O_DIRECTORY <unfinished ...>

I hit ctrl-C when the ls command hangs.  Above is the tail of the strace output.
It doesn't tell you much, the interesting stuff happens in the automounter.

Is there a error log file for the automounter that is enabled by default?
Is there an easy recipe for restarting the automounter with debugging output on?

--chris










Michael Loftis wrote:
> <reply inline>
> 
> --On Monday, June 21, 2010 12:17 PM -0700 Chris Quenelle
> <chris.quenelle@oracle.com> wrote:
> 
>> When I use /net/host and /net/host.domain to access a file system
>> that is local to the current host, the second flavor of access will
>> hang.
> 
> Check the /etc/hosts file on the machine having the problem.  Usually
> this means that your'e expecting it to contact from/to one address (say
> the loopback in the case of hostname) but the hosts file has another for
> the hostname.domain case, or doesn't have one, so it's getting the
> external address via DNS.
> 
>>
>> We have a complex build environment running on multiple hosts,
>> so directory names often need to work either locally or remotely.
>> That's why we're using /net paths for the local host.
>>
>> Is this a known bug?
>>
>> I can supply more details, if necessary.
>> Rebuilding from source is not really practical in my environment.
>>
>> --chris
>>
>>
>>
>> _______________________________________________
>> autofs mailing list
>> autofs@linux.kernel.org
>> http://linux.kernel.org/mailman/listinfo/autofs
> 
> 
> 
> 
