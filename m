From: Joseph V Moss <jmoss@ecsmtp.pdx.intel.com>
Subject: Re: -Dvariable=value not working?
Date: Tue, 21 Sep 2010 15:35:07 -0700
Message-ID: <28702.1285108507@ichips.intel.com>
References: <4C502068.1070104@nerc.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: Your message of "Wed, 28 Jul 2010 05:19:52 PDT."
	<4C502068.1070104@nerc.ac.uk> 
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
To: "R.Gillman@nerc.ac.uk" <R.Gillman@nerc.ac.uk>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

> I've got a Suse SLES 11 system running automount 5.0.3 which stubbornly 
> refuses to variable substitution.
> 
[...]
> I've got LOCAL_OPTIONS="-DNERCARCH=linux" in /etc/sysconfig/autofs (I've 
> also tried "-D  NERCARCH=linux", "-D NERCARCH='linux'").
[...]
> friesian:/etc/sysconfig # ps -ef|grep automount
> 
> root 14378 1 0 11:12 ? 00:00:00 /usr/sbin/automount -p 
> /var/run/automount.pid -O -DNERCARCH=linux
                         ^^^^

The -O option is consuming the next arg and using '-DNERCARCH=linux'
as a mount option.

The SLES11 autofs init script uses $LOCAL_OPTIONS like this:

	AUTOFS_OPTIONS="-O $LOCAL_OPTIONS $AUTOFS_OPTIONS"

So you need the beginning of your LOCAL_OPTIONS to be mount options.
After those, you can then do your variable assignments.

For example:

LOCAL_OPTIONS="tcp,hard,intr -DNERCARCH=linux"
