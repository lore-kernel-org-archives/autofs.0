From: Chris Feist <cfeist@redhat.com>
Subject: Re: [PATCH] check nsswitch.conf for submounts
Date: Mon, 28 Feb 2005 11:00:54 -0600
Message-ID: <42234E46.7090003@redhat.com>
References: <421D05BF.5000206@redhat.com>
	<Pine.LNX.4.61.0502271124090.8184@donald.themaw.net>
Reply-To: cfeist@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.61.0502271124090.8184@donald.themaw.net>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: raven@themaw.net
Cc: autofs@linux.kernel.org

raven@themaw.net wrote:
> This is a really useful bit of code.
> Appart from addressing the default map problem, it is one of the pieces 
> of code needed to move logic out of the init script.
> 
> Howerver, we can't assume that maps are stored in "/etc".
> This really should be a configure logical.

We do use _PATH_NSSWITCH_CONF for the location of the nsswitch.conf file which 
is defined in netdb.h.  So if that file was someplace else I would expect that 
the changes would need to be made in netdb.h (for glibc, etc.)

Thanks,
Chris
