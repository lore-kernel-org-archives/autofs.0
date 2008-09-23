From: Ian Kent <raven@themaw.net>
Subject: Re: 'browse mode' issue
Date: Tue, 23 Sep 2008 18:18:22 +0800
Message-ID: <1222165102.8564.178.camel@raven.themaw.net>
References: <48D7BF38.5020709@inria.fr>
	<1222135535.8564.58.camel@raven.themaw.net> <48D8BC0A.20302@s3group.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <48D8BC0A.20302@s3group.cz>
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
To: Ondrej Valousek <webserv@s3group.cz>
Cc: autofs@linux.kernel.org

On Tue, 2008-09-23 at 11:51 +0200, Ondrej Valousek wrote:
> Nice information about the CPU involvement here.
> I used to use (and I am still using) the browse to "yes" and it is much
> less confusing for users I must say (never mind that you do not see the
> directory, just cd into it anyway...), but then I introduced the wild
> cards to reduce size of my maps. And obviously, the browse mode stopped
> working (as it can not cover all possibilities the wild card gives).
> But there is nothing we can do with, I guess......

Yeah, it's a tricky.

Occasionally, suggestions have been made about this might be over come
but, in reality there are to may ways that this could go badly wrong to
tackle it. Maybe one day ...

Ian
