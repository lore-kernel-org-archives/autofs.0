From: Valerie Aurora Henson <vaurora@redhat.com>
Subject: Re: [PATCH 2/4] Make MAX_ERR_BUF and PARSE_MAX_BUF use
	easier to audit
Date: Fri, 9 Jan 2009 14:54:51 -0500
Message-ID: <20090109195451.GI32333@shell>
References: <1231526823-18595-1-git-send-email-vaurora@redhat.com>
	<1231526823-18595-2-git-send-email-vaurora@redhat.com>
	<1231526823-18595-3-git-send-email-vaurora@redhat.com>
	<x49r63cfgpa.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <x49r63cfgpa.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Fri, Jan 09, 2009 at 02:00:01PM -0500, Jeff Moyer wrote:
> Valerie Aurora Henson <vaurora@redhat.com> writes:
> 
> > Signed-off-by: Valerie Aurora Henson <vaurora@redhat.com>
> 
> > @@ -1524,18 +1525,12 @@ int lookup_read_master(struct master *master, time_t age, void *context)
> >  			goto next;
> >  		}
> >  
> > -		blen = strlen(*keyValue) + 1 + strlen(*values) + 2;
> > -		if (blen > PARSE_MAX_BUF) {
> > +		if (snprintf(parse_buf, sizeof(parse_buf), "%s %s",
> > +			     *keyValue, *values) > sizeof(parse_buf)) {
> 
> I think this should be >=.

Yes, they all should be.  I'll regenerate.  Thanks,

-VAL
