From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH] FedFS file system client support
Date: Mon, 30 May 2011 12:15:20 +0800
Message-ID: <1306728920.3292.3.camel@perseus.themaw.net>
References: <20110526163545.3676.52586.stgit@dali.1015granger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=YP60XiGEvYLeRgx8P+yK41udJQo=;
	b=eQri0A0BTQXHzHAc9txu/FkwfrK7rpjnXeq6SS+cguWMBLy71dZMcc44FMCElfCMh02Db+FPLAhbhi+PpzR0vVvu9CATQSOdFqGSYSgsbwliC1w+nlq73asTRJyR5GxQtys/AYYx6e1Vv3y3hmKm7XjV/ItWLiXiBQfctNOu5FA=
In-Reply-To: <20110526163545.3676.52586.stgit@dali.1015granger.net>
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
To: Chuck Lever <chuck.lever@oracle.com>
Cc: autofs@linux.kernel.org, fedfs-utils-devel@oss.oracle.com

On Thu, 2011-05-26 at 12:39 -0400, Chuck Lever wrote:
> Hi-
> 
> The next release of fedfs-utils will provide all necessary components
> for a Linux NFS client to participate in a FedFS domain as a file
> system client.  This new utility is intended to be a part of the
> upcoming release.
> 
> I'm interested in comments on this approach.  Ian had suggested a new
> lookup module, but a program map looked simpler to prototype and has
> the great advantage of no dependencies between fedfs-utils and autofs.
> If program maps have some nasty problem that require the use of a
> lookup module, we can take that next step.

The only difficulty with using a program map is that to use it you need
to know the name of the of the <key> (aka. /nfs4/<key>) since, at the
moment, autofs can't enumerate program map keys.

Ian
