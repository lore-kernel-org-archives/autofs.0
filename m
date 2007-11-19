From: Sandra Bonus <mrsbonus1@yahoo.com>
Subject: Re: parse(sun): invalid location
Date: Sun, 18 Nov 2007 17:07:31 -0800 (PST)
Message-ID: <939831.90566.qm@web35507.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

The auto.samba script was included with the last post in the tar bundle.
However, I have now fixed it thanks Ian's analysis.
The auto.samba used an awk which contained a "sub".
I have now replaced the "sub" with "gsub" to ensure that it escapes all spaces

I didn't put this in my original post because it sounds so corny, but it stopped working and I hadn't changed anything (on the Linux box). Now I realise that someone had added/altered the Windows share to include the space.

Thanks very much for sorting this out


----- Original Message ----
From: Ian Kent <raven@themaw.net>
To: Sandra Bonus <mrsbonus1@yahoo.com>
Cc: autofs@linux.kernel.org
Sent: Friday, November 16, 2007 5:04:39 PM
Subject: Re: [autofs] parse(sun): invalid location


On Thu, 2007-11-15 at 21:10 -0800, Sandra Bonus wrote:
> Reproduce the problem using 
> 
> ls -l /smb/awmelfp01/awmelsales1_backupsOther debug info attached

I think the script has an error in it.

From the debug log I can see the bit that causes the problem is:

/TS\ SSP National "://awmelfp01/TS\ SSP National"

where the second space isn't being quoted.

Can you also post the auto.samba that you are using (whether it's just
the default or not) so I can check it out please.

Ian







      ____________________________________________________________________________________
Be a better sports nut!  Let your teams follow you 
with Yahoo Mobile. Try it now.  http://mobile.yahoo.com/sports;_ylt=At9_qDKvtAbMuh1G1SQtBI7ntAcJ
