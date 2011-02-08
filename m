From: Ian Kent <raven@themaw.net>
Subject: Re: autofs misbehaves when DNS RRs returns more ldap
 servers
Date: Tue, 08 Feb 2011 11:56:37 +0800
Message-ID: <1297137397.10090.4.camel@perseus>
References: <4D18885D.6010601@s3group.cz> <1293503090.5923.2.camel@perseus>
	<4D21A19D.3050303@s3group.cz> <1294297764.3010.8.camel@perseus>
	<4D2581F0.8020607@s3group.cz> <1294322864.2852.3.camel@perseus>
	<4D27115A.9010805@s3group.cz>  <4D496CF9.5040001@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=EVUMs+aJd8+xrLmWeeGIVpK927U=;
	b=Itd8Hqhb8dCp/zAfT8IDw874wnPtxQ5BsAxqtWYaSLwewCOgGa0fbk9NtmLupVXpuuCfYgcWV2aMaDDDvEnFqSI/ADb0NPg9Y+1lTnS4WlmLFQIrCH2tcCDwcjybP6efjNV3ToiEFSOsjEwYVbSouBMW/iTK8A0GYwwxJ3J1CTY=
In-Reply-To: <4D496CF9.5040001@s3group.cz>
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
To: Ondrej Valousek <webserv@s3group.cz>
Cc: autofs@linux.kernel.org

On Wed, 2011-02-02 at 15:40 +0100, Ondrej Valousek wrote:
> Hi Ian,
> 
> Did you have any chance to take a look at this patch yet?

Yes, and replied on the 11/01, did you miss it?

> Thanks,
> 
> Ondrej
> 
> On 07.01.2011 14:12, Ondrej Valousek wrote: 
> > On 06.01.2011 15:07, Ian Kent wrote: 
> > > Thanks for the suggestions.
> > > I'm still on leave so things are still going slowly for now, but I'll
> > > get to it.
> > Hi Ian,
> > 
> > Please find the attached patch which fixes the problem for me.
> > I also changed the "dclist" structure definition from:
> > 
> > struct dclist {
> >         time_t expire;
> >         const char *uri;
> > };
> > 
> > into:
> > 
> > struct dclist {
> >         time_t expire;
> >         char **uri;
> >         int cnt;
> > };
> > 
> > Hope you'll find it useful :-) .
> > Ondrej
> > 
> > _______________________________________________
> > autofs mailing list
> > autofs@linux.kernel.org
> > http://linux.kernel.org/mailman/listinfo/autofs
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
