From: Ian Kent <raven@themaw.net>
Subject: Re: direct mounts
Date: Fri, 26 Sep 2003 23:18:29 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0309262313480.4947-100000@raven.themaw.net>
References: <7EA66ACBFB7B8B4DA4C306BDAD178A5E227B73@abz-irg-exs01>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <7EA66ACBFB7B8B4DA4C306BDAD178A5E227B73@abz-irg-exs01>
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
To: "Salmon, Michael" <MICHAEL.SALMON@saic.com>
Cc: "'autofs@linux.kernel.org'" <autofs@linux.kernel.org>

On Fri, 26 Sep 2003, Salmon, Michael wrote:

> Hi all I have just joined the list. I have been reading through some
> previous posts particuraly about direct automounts. Can anyone tell me if
> they are working yet. If so What do I need to get them working?
> 

Oh, if only I could sort out the bugs I would have a beta out right now.

Hopefully soon.

I have some rather old patches but I recommend against them as they won't 
work with recent kernels.

Main thing that can't be done with the current implementation is cross 
filesystem mounts in a direct map. Mostly this is not done in direct maps 
anyway and has not been a problem in practice as yet.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
