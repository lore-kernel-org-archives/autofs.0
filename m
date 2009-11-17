From: Ian Kent <raven@themaw.net>
Subject: Re: disable direct mounts
Date: Tue, 17 Nov 2009 14:30:01 +0800
Message-ID: <4B0242E9.4050808@themaw.net>
References: <Pine.LNX.4.61.0911161206540.6189@bos.adc.idt.com>
	<4B01FA71.5070300@themaw.net>
	<Pine.LNX.4.61.0911170004530.26324@bos.adc.idt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0911170004530.26324@bos.adc.idt.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: devnull@adc.idt.com
Cc: autofs@linux.kernel.org

devnull@adc.idt.com wrote:
>>> We would like to continue to disable direct mounts. The other option is
>>> to use a different "auto.master" w/o the auto.direct, but we would like
>>> to avoid that.
>>
>> Why do you want to disable direct mounts?
> To solve our /usr/local issue.
> 
> Our NIS master is a Solaris box. We have an entry in auto.direct for
> /usr/local that currently points to our Sun Solaris binaries.
> The auto.direct is included in our auto.master
> 
> We are considering a move to autofs 5.x as part of our OS upgrade. We
> could create a separate auto.master.lnx that does not have auto.direct
> in it, but we prefer not to do that.
> 
> "Solving the /usr/local/ puzzle" as the NIS and NFS book suggests is
> something we can do, I am just not sure if we can do that right away.

That is probably the best solution.
You can use built in macros in the mount location of your maps to
achieve that. See autofs(5).

> 
> So someway to disable auto.direct would be useful for us.

You don't say if your maps are always from local files or some other source.

> 
> Thanks.
