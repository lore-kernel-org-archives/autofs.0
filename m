From: Ian Kent <raven@themaw.net>
Subject: Re: parse(sun): invalid location
Date: Mon, 19 Nov 2007 11:10:00 +0900
Message-ID: <1195438200.3742.1.camel@raven.themaw.net>
References: <939831.90566.qm@web35507.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <939831.90566.qm@web35507.mail.mud.yahoo.com>
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
To: Sandra Bonus <mrsbonus1@yahoo.com>
Cc: autofs@linux.kernel.org

On Sun, 2007-11-18 at 17:07 -0800, Sandra Bonus wrote:
> The auto.samba script was included with the last post in the tar bundle.
> However, I have now fixed it thanks Ian's analysis.
> The auto.samba used an awk which contained a "sub".
> I have now replaced the "sub" with "gsub" to ensure that it escapes all spaces

Yep.

You might like to check the auto.smb that is included with the package.
It uses double quotes around both the mount point and the target to
achieve the same result.

Ian
