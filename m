From: Ian Kent <raven@themaw.net>
Subject: Re: Wrong network
Date: Tue, 15 Feb 2011 11:06:02 +0800
Message-ID: <1297739162.13007.7.camel@perseus>
References: <alpine.LRH.0.9999.1102120924290.6851@helios.vgersoft.com>
	<alpine.LRH.0.9999.1102121518420.12882@helios.vgersoft.com>
	<1297649183.2822.6.camel@perseus>
	<alpine.LRH.0.9999.1102141420430.25310@firefly.vgersoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com;
	h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:content-transfer-encoding;
	s=smtpout; bh=8amcxDzssDYIZyY3xOewxabeSUI=;
	b=SLv0SqW9zzWAaBl3uO8H7tTNPek3GBa/msgHKM0GYnRDUVFxYf1bZv+GzjttooJbahoLBvXfNv6UGCgM3x+eWz5i8rAMNSDOX3CxkhMTVbiBMBv2i0qrP8ZScF2DGmae9XOlButfReVSCDViZhFCYipUADavBmkLSEo+ZnVhIgE=
In-Reply-To: <alpine.LRH.0.9999.1102141420430.25310@firefly.vgersoft.com>
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
To: Steve Thompson <smt@vgersoft.com>
Cc: autofs@linux.kernel.org

On Mon, 2011-02-14 at 14:22 -0500, Steve Thompson wrote:
> On Mon, 14 Feb 2011, Ian Kent wrote:
> 
> > That is the way it should work but dns round robin entries like this
> > aren't handled quite correctly.
> >
> > I'm not sure this patch will apply (the CHANGELOG hunk certainly won't)
> > but you could try it:
> 
> Unfortunately I am not able to try this - I can use only the .rpm's that 
> come from the CentOS repo. Hopefully this patch will make it upstream 
> soon, given the seriousness of this issue.

That's a lame response, given you think it's a serious issue.
I guess you won't be prepared to test a pre-built package either.
If you are willing to test the change try:
http://people.redhat.com/~ikent/autofs-5.0.1-0.rc2.145.bz520844.2.el5

Ian
