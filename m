From: raven@themaw.net
Subject: Re: Possbile issue with ghost and timeout
Date: Mon, 28 Jun 2004 21:47:40 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0406282145360.14360@donald.themaw.net>
References: <20040626190912.27576.qmail@web51801.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20040626190912.27576.qmail@web51801.mail.yahoo.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Phy Prabab <phyprabab@yahoo.com>
Cc: autofs@linux.kernel.org

On Sat, 26 Jun 2004, Phy Prabab wrote:

> Hello,
> 
> I am not on this mailing list yet, so please cc me in
> the mails.
> 
> I have an issue with autofs4.1.3 and ghost option.  It
> appears that onve a file system has been mounted and
> then time-out removed, the file system will not be
> remounted unless you cd or ls the dir.  For example: 
> I run an executable by using the full path via an rsh
> command and then run the command again after the
> timeout (30s in my case) and the file is not found. 
> However if I "ls" the path the executable is there and
> then accessable.

Have you applied the kernel module update?
What release?

> 
> If I remove the ghost option, everything behaves fine.
> 
> Is this a known issue and is there a fix/work around?

Not aware of this.

Ian
