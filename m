From: David Meleedy <david.meleedy@analog.com>
Subject: strange BUG reported by automount using /net directory
Date: Mon, 13 Dec 2004 19:23:02 -0500
Message-ID: <200412140023.iBE0N25k006225@jetcar.spd.analog.com>
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


autofs vers: autofs-4.1.3-12

alfalfa-71: uname -a
Linux alfalfa.spd.analog.com 2.4.21-20.ELsmp #1 SMP Wed Aug 18 20:46:40 EDT 
2004 i686 i686 i386 GNU/Linux

alfalfa-72: cat /etc/redhat-release 
Red Hat Enterprise Linux WS release 3 (Taroon Update 3)

Nothing else is going on, on this machine, I just cd to a directory
using /net and get the following:

Note: this seems to happening exactly once per minute, which is
what the timeout value is set to (note that I am running automounter
with --debug and --verbose turned on):

alfalfa-54: cd /net/aflac/vol/vol2
alfalfa-58: tail -f /var/log/messages
Dec 13 19:09:55 alfalfa automount[4324]: BUG: /net/aflac/vol/vol2 already 
mounted
Dec 13 19:10:56 alfalfa automount[4453]: BUG: /net/aflac/vol/vol2 already 
mounted
Dec 13 19:11:56 alfalfa automount[4578]: BUG: /net/aflac/vol/vol2 already 
mounted
Dec 13 19:12:57 alfalfa automount[4702]: BUG: /net/aflac/vol/vol2 already 
mounted

...etc...

Note, I have not changed the /etc/auto.net file that came with
RHE3,u3. 

alfalfa-64: showmount -e aflac | grep vol2
/vol/vol2                 (everyone)

-Dave

________________________________________________________________________
David Meleedy				Analog Devices, Inc.
David.Meleedy@analog.com		Three Technology Way
Phone: 781 461 3494			Norwood, MA  02062-9106  USA
