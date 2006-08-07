From: Ian Kent <raven@themaw.net>
Subject: Re: Lost patch
Date: Mon, 07 Aug 2006 15:01:03 +0800
Message-ID: <1154934063.11586.3.camel@raven.themaw.net>
References: <44D21274.9040405@inria.fr>
	<1154699891.25506.0.camel@raven.themaw.net> <44D3536A.6060502@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <44D3536A.6060502@inria.fr>
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
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs@linux.kernel.org

On Fri, 2006-08-04 at 16:02 +0200, Guillaume Rousse wrote:
> Ian Kent wrote:
> > On Thu, 2006-08-03 at 17:12 +0200, Guillaume Rousse wrote:
> >> I tried two times already to send a patch to the list without success,
> >> despite they were quite small (5Kb). What is the problem ?
> > 
> > Don't know.
> > It looks like they never reached the list server.
> > I can't see anything waiting in the moderator queue.
> Strange.
> Here it is, keeping you in CC this time.
> 
> Current autofs code prefixes all its configuration directive with
> DEFAULT, which is misleading: what you configure is actual value,
> whereas default is what is used when no actual value is provided.
> 
> The attached patche remove the DEFAULT_ prefix for all these variables,
> and rework the sample configuration file to have all its directives
> commented with their default values, as openssh does, to make it clearer.

Please don't send patches as attachments put them in-line with the mail.
It's a pain reply with comments.

Ian
