From: raven@themaw.net
Subject: Re: Bug#304245: patch - NFS mounts occasionally fail
Date: Wed, 20 Apr 2005 19:27:45 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504201927070.1883@donald.themaw.net>
References: <20050417154240.GA17232@uio.no>
	<Pine.LNX.4.62.0504200059370.8587@donald.themaw.net>
	<20050419210653.GA15270@vision.ime.usp.br>
	<Pine.LNX.4.58.0504200859160.7460@wombat.indigo.net.au>
	<20050420013214.GA9960@vision.ime.usp.br>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20050420013214.GA9960@vision.ime.usp.br>
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
To: Daniel Andre Vaquero <daniel@vision.ime.usp.br>
Cc: autofs@linux.kernel.org, 304245@bugs.debian.org

On Tue, 19 Apr 2005, Daniel Andre Vaquero wrote:

> On Wed, Apr 20, 2005 at 09:02:22AM +0800, Ian Kent wrote:
>>
>> Fine, but what I'm after is what happpens when the ping fails for all
>> servers. Changing the host names to bogus names should be enough.
>
> Changed /etc/auto.testing to
>
> foo     -ro,hard,intr \
>        /dir/bar        bogus:/usr/local/bin \
>        /dir/baz        morebogus:/usr/local/sbin
>
> cd /testing/foo resulted in the part of the log that follows attached.
>

Cool.

That seems to work properly.
Thanks for doing that for me.

Ian
