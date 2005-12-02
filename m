From: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [autofs] [RFC PATCH]autofs4: hang and proposed fix
Date: Fri, 02 Dec 2005 13:12:27 -0500
Message-ID: <1133547148.8976.25.camel@lade.trondhjem.org>
References: <20051116101740.GA9551@RAM>
	 <17292.64892.680738.833917@segfault.boston.redhat.com>
	 <1133315771.8978.65.camel@lade.trondhjem.org> <438E0C66.6040607@us.ibm.com>
	 <1133384015.8974.35.camel@lade.trondhjem.org> <438E1A05.7000308@us.ibm.com>
	 <Pine.LNX.4.63.0512011917010.3189@donald.themaw.net>
	 <438F251B.7060602@us.ibm.com>
	 <Pine.LNX.4.63.0512022059350.2070@donald.themaw.net>
	 <43906968.6080508@us.ibm.com>
	 <Pine.LNX.4.63.0512030115310.2632@donald.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0512030115310.2632@donald.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: Will Taber <wtaber@us.ibm.com>, Jeff Moyer <jmoyer@redhat.com>, Ram Pai <linuxram@us.ibm.com>, autofs mailing list <autofs@linux.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>

On Sat, 2005-12-03 at 01:29 +0800, Ian Kent wrote:

> It's sufficient to recognize the nameidata struct is NULL on a call 
> from lookup_hash nothing more that I'm aware of is needed. If that changes 
> then of course autofs will need to be changed. autofs also makes 
> assumptions about what flags are set for different reasons.

Consider those cases where the VFS calls ->lookup()/->d_revalidate()
with the nameidata argument set to NULL to be bugs. They are pretty much
all slated to be fixed soon in order to enable features like read-only
bind mounts etc.

Cheers,
  Trond

