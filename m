From: David Meleedy <david.meleedy@analog.com>
Subject: A different automounter problem: "BUG messages"
Date: Tue, 30 Nov 2004 15:18:45 -0500
Message-ID: <200411302018.iAUKIjoO020709@jetcar.spd.analog.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org


We have a site that has the following errors constantly showing
up in their /var/log/messages file (again this is Redhat Enterprise
3 WS, update 3 for AMD64).

Nov 30 12:32:36 ho automount[5287]: >> mount: slcnetapp:/vol/vol0/etc failed, 
reason given by server: Permission denied
Nov 30 12:32:36 ho automount[5287]: mount(nfs): nfs: mount failure 
slcnetapp:/vol/vol0/etc on /net/slcnetapp/vol/vol0/etc
Nov 30 12:36:52 ho automount[5614]: >> mount: slcnetapp:/vol/vol0/etc failed, 
reason given by server: Permission denied
Nov 30 12:36:52 ho automount[5614]: mount(nfs): nfs: mount failure 
slcnetapp:/vol/vol0/etc on /net/slcnetapp/vol/vol0/etc
Nov 30 12:36:52 ho automount[5614]: BUG: /net/slcnetapp/vol/vol0 already 
mounted
Nov 30 12:36:52 ho automount[5614]: BUG: /net/slcnetapp/vol/vol0/soft already 
mounted

Strangely, if you try to:

cd /net/slcnetapp/vol/vol0/etc

it works.  The permissions on the filer look like this:

[dmeleedz@ho ~]$ cd /net/slcnetapp/vol/vol0/etc
[dmeleedz@ho etc]$ cat exports
/vol/vol0       -root=host1.spd.analog.com:host2.spd.analog.com
/vol/vol0/cpd   -root=host1.spd.analog.com
/vol/vol0/proj  -access=netgroup1:netgroup2:netgroup3,root=host1
/vol/vol0/soft  -access=netgroup4,root=host1

-Dave

________________________________________________________________________
David Meleedy				Analog Devices, Inc.
David.Meleedy@analog.com		Three Technology Way
Phone: 781 461 3494			Norwood, MA  02062-9106  USA
