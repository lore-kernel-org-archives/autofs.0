From: raven@themaw.net
Subject: Re: [PATCH] replicated mounts fix, also possible bug in
	beta2?
Date: Sat, 9 Apr 2005 11:30:40 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504091126390.1622@donald.themaw.net>
References: <1112442929.5055.18.camel@tleilax.poochiereds.net>
	<Pine.LNX.4.62.0504030041050.9613@donald.themaw.net>
	<1112470286.5015.20.camel@tleilax.poochiereds.net>
	<Pine.LNX.4.62.0504031153230.8220@donald.themaw.net>
	<424FC16B.4030006@poochiereds.net>
	<Pine.LNX.4.58.0504041017210.27508@wombat.indigo.net.au>
	<1112970073.21287.64.camel@barsoom.rdu.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1112970073.21287.64.camel@barsoom.rdu.redhat.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Jeffrey Layton <jtlayton@poochiereds.net>
Cc: autofs@linux.kernel.org

On Fri, 8 Apr 2005, Jeffrey Layton wrote:

> Ok, here's an updated patch. I did end up using 'indent' to do it. This
> is the first time I've used it, but it seems to have done a pretty
> decent job.
>
> Some of the lines are still over 80 cols, but most of those are strings
> in debug statements that are in heavily nested sections of code -- it
> was either go over 80 columns or violate the 8 char tab rule. I went
> with the former. Let me know what you think.
>

Thanks Jeff.

As I've said before this looks like a big improvement and I'll get to it 
as soon as I can.

The reformat looks like it will save me quite a bit of time as well.

Work is building up again so I'm keen to get 4.1.4 out the door before 
I get completely swamped.

Ian
