From: Alvin Oga <alvin@Mail.Linux-Consulting.com>
Subject: Re: Repeated Meessages - sendmail
Date: Fri, 23 Jan 2004 23:29:50 -0800 (PST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.3.96.1040123232708.2194A-100000@Maggie.Linux-Consulting.com>
References: <Pine.LNX.4.58.0401241328060.1810@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0401241328060.1810@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: raven@themaw.net
Cc: autofs@linux.kernel.org



hi ya

On Sat, 24 Jan 2004 raven@themaw.net wrote:

> I have been having problems with their qmail mail server for some time 
> now.
> 
> Am now relaying through my server temporarily. 
> 
> I can't work out how to sufficiently restrict relaying in sendmail, for my 
> dynamic ADSL IP, to continue this for long. Any sendmail people out there?

if you have your own mail server ... use it .. instead of the isp..

sendmail is ez to config -- create sendmail.mc 
	cd /usr/local/src/sendmail-8.12.10
	sh Build
	sh Build Install

	cd cf/cf
	cp linux.mc sendmail.mc
	sh Build sendmail.cf
	cp sendmail.cf sendmail.mc /etc/mail

	- fix your local-host-name ( sendmail.cw )
	and magic

	http://www.Linux-Sec.net/Mail/Sendmail

c ya
alvin
