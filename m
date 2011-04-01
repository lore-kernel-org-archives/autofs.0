From: Ian Kent <raven@themaw.net>
Subject: Re: different behaviour of autofs
Date: Fri, 01 Apr 2011 12:14:01 +0800
Message-ID: <1301631241.2880.1.camel@perseus>
References: <4D903E64.6050901@mx9.artware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=W9qlz0as6bGkUA7xlrYzOucwml4=;
	b=bxIqN5CNpyUPgOW+nIWW34OpYj2owb+kGTRPcflorz+Rkun5MUs0CZA39RVnOo6F5lFQAHyrVI3mtoKyjURTKRLrC4YAbUwF4q62Lckr2OOY24K6VLZSUS9tfE2/VoOeUZQu2TDQir4ycL6ppLTJQiPEwvWQHnw6OzVvp8u0J9c=
In-Reply-To: <4D903E64.6050901@mx9.artware.nl>
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
To: hugo tempo <hugo@mx9.artware.nl>
Cc: autofs@linux.kernel.org

On Mon, 2011-03-28 at 09:53 +0200, hugo tempo wrote:
> Hi,
> We (@vu.nl) use the automounter with ldap, a.o. to automount 
> home-directories.
> Now under squeeze if we do a wildcard access (ls /home/* or even ls 
> /home) we get a listing of (seemingly) all the userdirectories from the 
> mountmap (in ldap), which are certainly not all mounted under /home on 
> that specific machine. Same story with /net where we automount packages.
> With lenny we never saw this behaviour, which we honestly do not appreciate.
> Anybody knowing the specifics about this?

Specifics about what.
Perhaps you expect me to just guess the version history and the changes
you have made to your autofs configuration.

Ian
