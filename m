From: Paul Jakma <paul@clubi.ie>
Subject: Re: submount vs automount
Date: Mon, 28 Jun 2004 16:59:56 +0100 (IST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.60.0406281651490.13910@fogarty.jakma.org>
References: <482A3FA0050D21419C269D13989C61130435E309@lavender-fe.eng.netapp.com>
	<Pine.LNX.4.58.0406252225430.1375@donald.themaw.net>
	<40DC6F84.5020701@sun.com><40E03CC2.7020601@sun.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40E03CC2.7020601@sun.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Mike Waychison <Michael.Waychison@sun.com>
Cc: autofs@linux.kernel.org, raven@themaw.net

On Mon, 28 Jun 2004, Mike Waychison wrote:

>> Why should the user on :0 be special?
>
> Cause this is the kind of policy I'd like to see :)

It doesnt make sense though. Eg, I remember in College the 
SPARCStation labs (for some reason) each only had one workstation 
with a floppy device. 9/10 the user using the floppy was not on :0.0.

I can imagine something similar today with Zip/Jazz/DVR-RW+packet 
UDF/$CHIC_REMOVABLE_MEDIA_DE_JOUR.

> Yup. However, this doesn't connect nicely with mount(8).  mount(8) 
> only mounts as a user according to /etc/fstab rules, not by block 
> device owner :\ Maybe this should be fixed up somehow.

Hmm, that's a decent point.

> Sure, but 'who is allowed to trigger the mount'?

Whoever is allowed to access the device surely?

> --
> Mike Waychison
> Sun Microsystems, Inc.
> 1 (650) 352-5299 voice
> 1 (416) 202-8336 voice
> http://www.sun.com

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
 	warning: do not ever send email to spam@dishone.st
Fortune:
Victory uber allies!
