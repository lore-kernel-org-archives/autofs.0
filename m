From: Ian Kent <raven@themaw.net>
Subject: Re: disable direct mounts
Date: Tue, 17 Nov 2009 09:20:49 +0800
Message-ID: <4B01FA71.5070300@themaw.net>
References: <Pine.LNX.4.61.0911161206540.6189@bos.adc.idt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0911161206540.6189@bos.adc.idt.com>
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
> Is it still possible to disable direct mounts via DISABLE_DIRECT=1
> Automount version 5.0.1-0.rc2.102

No it isn't.

> 
> We would like to continue to disable direct mounts. The other option is
> to use a different "auto.master" w/o the auto.direct, but we would like
> to avoid that.

Why do you want to disable direct mounts?

Ian
