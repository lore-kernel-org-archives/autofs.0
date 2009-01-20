From: Valerie Aurora Henson <vaurora@redhat.com>
Subject: Re: [RFC PATCH 1/3] Make MAX_ERR_BUF and PARSE_MAX_BUF use
	easier to audit
Date: Mon, 19 Jan 2009 22:05:35 -0500
Message-ID: <20090120030535.GA1525@shell>
References: <1232164730-9397-1-git-send-email-vaurora@redhat.com>
	<1232164730-9397-2-git-send-email-vaurora@redhat.com>
	<1232172128.3072.8.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <1232172128.3072.8.camel@zeus.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, Paul Wankadia <junyer@google.com>

On Sat, Jan 17, 2009 at 03:02:08PM +0900, Ian Kent wrote:
> On Fri, 2009-01-16 at 19:58 -0800, Valerie Aurora Henson wrote:
> > @@ -1523,18 +1524,12 @@ int lookup_read_master(struct master *master, time_t age, void *context)
> >  			goto next;
> >  		}
> >  
> > -		blen = strlen(*keyValue) + 1 + strlen(*values) + 2;
> > -		if (blen > PARSE_MAX_BUF) {
> > +		if (snprintf(parse_buf, sizeof(parse_buf), "%s %s",
> > +			     *keyValue, *values) > sizeof(parse_buf)) {
> 
> Think that has to be >=, as Jeff mentioned earlier.

Yes, thanks for catching that and fixing it in your respin.

-VAL
