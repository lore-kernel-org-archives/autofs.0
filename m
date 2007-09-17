From: Ian Kent <raven@themaw.net>
Subject: Re: Reports of huge CPU usage with 5.0.2
Date: Mon, 17 Sep 2007 11:19:56 +0800
Message-ID: <1189999196.3124.6.camel@raven.themaw.net>
References: <46ED96B6.8070305@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <46ED96B6.8070305@inria.fr>
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

On Sun, 2007-09-16 at 22:48 +0200, Guillaume Rousse wrote:
> Hello.
> 
> I have several reports from users having constant 20% cpu usage from
> automounter since 5.0.2 release, but I can't reproduce myself: see
> http://qa.mandriva.com/show_bug.cgi?id=32611
> 
> Is anyone else here facing the same problem ?

About comment #4 and browsing.

If this is enabled the CPU usage is directly proportional to the number
of entries in indirect maps. So, if someone has 30000+ keys CPU usage
will be really high but if someone has 500-1500 the CPU usage should be
OK.

Ian
