From: Francesco Paolo Lovergine <frankie@debian.org>
Subject: Re: Looking for a per user submount...
Date: Tue, 29 Jan 2008 15:33:48 +0100
Message-ID: <20080129143348.GA3972@mithrandir>
References: <20080128101153.GE5803@mithrandir>
	<1201570926.3072.17.camel@raven.themaw.net>
	<479F37BD.3050900@anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <479F37BD.3050900@anl.gov>
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
To: autofs@linux.kernel.org

On Tue, Jan 29, 2008 at 08:27:09AM -0600, Douglas E. Engert wrote:
>
>
> Ian Kent wrote:
>> On Mon, 2008-01-28 at 11:11 +0100, Francesco P. Lovergine wrote:
>>> I was looking for some sort of automounting for per-user subtrees.
>>> Essentially I need to bind-mount on demand some per user (users are sql-based)
>>> subdir like /path/<user>/mount_point, where /path/<user> is a true 
>>> dir. I'm missing something or it cannot be performed using autofs 
>>> without
>>> adding each entry explicitly for every users ?
>
> Have you looked at using an executable map? Something like in the master map:
> /topdir   program:/etc/auto_per_user
>
> /etc/auto_per_user:
> #!/bin/sh
> # $1 is <user>
> echo ":/path/$1/mount_point"
>

Is this an autofs5-only feature? That could be useful I think...

-- 
Francesco P. Lovergine
