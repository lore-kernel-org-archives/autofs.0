From: Sandra Bonus <mrsbonus1@yahoo.com>
Subject: Re: parse(sun): invalid location
Date: Thu, 15 Nov 2007 21:10:36 -0800 (PST)
Message-ID: <651920.10654.qm@web35502.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-369407791-1195189836=:10654"
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

--0-369407791-1195189836=:10654
Content-Type: text/plain; charset=us-ascii

Reproduce the problem using 

ls -l /smb/awmelfp01/awmelsales1_backupsOther debug info attached


----- Original Message ----
From: Ian Kent <raven@themaw.net>
To: Sandra Bonus <mrsbonus1@yahoo.com>
Cc: autofs@linux.kernel.org
Sent: Friday, November 16, 2007 2:23:36 PM
Subject: Re: [autofs] parse(sun): invalid location


On Tue, 2007-11-13 at 20:22 -0800, Sandra Bonus wrote:
> Running autofs-5.0.1-0.rc3.33 on Fedora Core 6.
> 
> I'm trying to mount a share on a Windows 2003 server in a domain.
 nslookup returns the correct IP address and I can ping it.
> I have a domain username/password that gives me admin access to this
 server as well as to my local PC.
> For the purpose of this I create a local (not domain) user called
 awmelsales1 and a share called awmelsales1_backups. I do this on the
 server and on my PC.


All I can do is to try to duplicate this is to make a program map that
"echo"s the entry in the same way that your script does.

Doing that I don't see the problem you're having.
You will need to provide a debug log as I mentioned earlier.

Ian







      ____________________________________________________________________________________
Never miss a thing.  Make Yahoo your home page. 
http://www.yahoo.com/r/hs
--0-369407791-1195189836=:10654
Content-Type: application/x-tar; name="=?utf-8?q?autofs.debug.tar?="
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="=?utf-8?q?autofs.debug.tar?="

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
JOH/AfpV//4A8AAA

--0-369407791-1195189836=:10654
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--0-369407791-1195189836=:10654--

