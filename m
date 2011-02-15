From: Mike Marion <mmarion@qualcomm.com>
Subject: Re: 5.0.5 non-expiring mounts
Date: Mon, 14 Feb 2011 21:28:58 -0800
Message-ID: <20110215052857.GV27735@sunapee.qualcomm.com>
References: <4D510D53.7010507@gmail.com>
	<20110215011037.GT27735@sunapee.qualcomm.com>
	<1297739464.13007.8.camel@perseus>
	<1297741021.13007.12.camel@perseus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=qualcomm.com; i=mmarion@qualcomm.com; q=dns/txt;
	s=qcdkim; t=1297752956; x=1329288956;
	h=x-authentication-warning:date:from:to:cc:subject:
	message-id:references:mime-version:content-type:
	content-disposition:in-reply-to:x-operating-system:
	x-distribution:user-agent;
	z=X-Authentication-Warning:=20sunapee.qualcomm.com:=20mmar
	ion=20set=20sender=20to=20mmarion@qualcomm.com=20using=20
	-f|Date:=20Mon,=2014=20Feb=202011=2021:28:58=20-0800
	|From:=20Mike=20Marion=20<mmarion@qualcomm.com>|To:=20Ian
	=20Kent=20<raven@themaw.net>|Cc:=20"autofs@linux.kernel.o
	rg"=20<autofs@linux.kernel.org>|Subject:=20Re:=20[autofs]
	=205.0.5=20non-expiring=20mounts|Message-ID:=20<201102150
	52857.GV27735@sunapee.qualcomm.com>|References:=20<4D510D
	53.7010507@gmail.com>=20<20110215011037.GT27735@sunapee.q
	ualcomm.com>=20<1297739464.13007.8.camel@pers 
Content-Disposition: inline
In-Reply-To: <1297741021.13007.12.camel@perseus>
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
To: Ian Kent <raven@themaw.net>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Mon, Feb 14, 2011 at 07:37:01PM -0800, Ian Kent wrote:

> That is kernel revision and autofs revision?

2.6.16.60-0.59.1 (Sles10 sp3 with an updated, but not bleeding edge, patch).
autofs 5.0.5 with most of the patches up to a couple months ago.  It's hard to
get exacts because it's a PTF from Novell (we really pushed them to upgrade to
5.0.5) but it should be pretty much equal to the patch they just released for
sle 11 sp1 that they're recommending as they default going forward.

-- 
Mike Marion-Unix SysAdmin/Staff IT Engineer-http://www.qualcomm.com
Vir: "Londo, are you deliberatly trying to drive me insane?"
Londo: "The Universe is already mad.  Anything else would be redundant."
==> Babylon 5
