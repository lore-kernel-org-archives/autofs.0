From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: Replicated hosts in autofs v4.
Date: Mon, 11 Oct 2004 00:53:40 +0300
Sender: autofs-bounces@linux.kernel.org
Message-ID: <200410110053.40587.vda@port.imtp.ilyichevsk.odessa.ua>
References: <bf092570041010091873f86c2f@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <bf092570041010091873f86c2f@mail.gmail.com>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Jeremy Rosengren <jeremy.rosengren@gmail.com>, autofs@linux.kernel.org

On Sunday 10 October 2004 19:18, Jeremy Rosengren wrote:
> I've previously posted about this problem, but I still haven't found
> an answer, although I think I better understand what's happening.
> 
> We have an automount map called "auto_group" that looks like this:
> 
> icdes     ausfiler,minnfiler:/vol/vol0/data/group/&
> 
> ausfiler lives in Texas, minnfiler lives in Minnesota.  Between
> ausfiler and minnfiler lies a T1 line.
> 
> On the MInnesota office network, from a RedHat Enterprise 3.0 Update 3
> client (using autofs-4.1.3-12), cd'ing into /group/icdes mounts
> ausfiler:/vol/vol0/data/group/icdes.  No matter what...it always
> mounts ausfiler.  The problem is that ausfiler is on the other end of
> a T1 from the client, whereas minnfiler is on the same subnet, on the
> same network switch.

Your config does not let the system know that you prefer minnfiler
over ausfiler if both are available.

> I filed a support ticket with RedHat Global support, and an engineer
> there confirmed that the client does an RPC call with a  .1 second
> timeout.  However, the client's behavior indicates to me that the
> comparison being made in the reponse times between the replicated
> mount servers isn't fine-grained enough to make the correct choice.  A
> coworker made the comment that our T1 line could be "too robust",
> making the server farther away appear to be good enough for the
> client's purposes.
> 
> Solaris doesn't seem to have any issues with doing this properly.  A

Prolly Solaris does not use first server from the set of those which
answered, it uses server which _answers first_.
--
vda
