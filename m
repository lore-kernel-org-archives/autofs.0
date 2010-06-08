From: Ian Kent <raven@themaw.net>
Subject: Re: Loopback mounting seems to fail
Date: Tue, 08 Jun 2010 23:48:29 +0800
Message-ID: <1276012109.2486.2.camel@localhost>
References: <alpine.LSU.2.01.1006081456230.26148@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=SOq5/upJ1MudPiq06oY9OGVZtGU=;
	b=uhLhuHdPBuFhdYObPDhxLGJqm9i1iELNyh5kMT9CWAGvx9Nm3HGBUnMwGxsyIF3zpB4LB5QwTqWvPpOFsPcqYIZ//7QYMeWFe26YqF/It4CjD0xYIUiLNlqa8OI9Jf3KKWpr78h/i8/sPYpog0l0YeVzqRqFEHLkx5MrBLhYahU=
In-Reply-To: <alpine.LSU.2.01.1006081456230.26148@obet.zrqbmnf.qr>
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
To: Jan Engelhardt <jengelh@medozas.de>
Cc: autofs@linux.kernel.org

On Tue, 2010-06-08 at 14:59 +0200, Jan Engelhardt wrote:
> Hi,
> 
> 
> I have here an openSUSE 11.2 with 2.6.33.5 and autofs-5.0.4-6.2.1.x86_64
> 
> /etc/auto.master:
> +auto.master
> /-	auto.direct
> 
> /etc/auto.direct:
> /data/repository/sles11/x64/dvd1	-fstype=iso9660,loop,ro	/data/iso/lin/os/sles/11/SLES-11-DVD-x86_64-GM-DVD1.iso

This is an invalid entry.
A mount location can't start with "/", you need to use a ":" escape in
this case.

/data/repository/sles11/x64/dvd1 -fstype=iso9660,loop,ro :/data/iso/lin/os/sles/11/SLES-11-DVD-x86_64-GM-DVD1.iso
