From: chris barry <Christopher.Barry@qlogic.com>
Subject: Re: simple automount question
Date: Wed, 05 Mar 2008 02:04:48 -0500
Message-ID: <1204700689.9164.5.camel@localhost>
References: <1204517826.5312.62.camel@localhost>
	<1204543130.29431.8.camel@raven.themaw.net>
	<1204556356.5312.97.camel@localhost>
	<1204686063.3081.21.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1204686063.3081.21.camel@raven.themaw.net>
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
Cc: autofs mailing list <autofs@linux.kernel.org>

On Wed, 2008-03-05 at 12:01 +0900, Ian Kent wrote:
> If you are saying that 10.20.30.40:/foo is an export that you want to
> mount on a single level directory path, /foo in this case, then you
> will
> need to use a direct mount and version 5 of autofs. This won't work in
> version 4 and never will.
> 
> For example, in the master map
> /-      /etc/auto.direct
> 
> and in auto.direct
> /foo    10.20.30.40:/foo
> 
> will do this.
> 
> Ian

Ian,

That was the answer I was looking for.

Thank You,
-C
