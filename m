From: Ian Kent <raven@themaw.net>
Subject: Re: shell environment when mounting
Date: Wed, 16 Sep 2009 11:33:53 +0800
Message-ID: <4AB05CA1.1020907@themaw.net>
References: <4AAE47CB.5050603@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4AAE47CB.5050603@bononline.nl>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Stef Bon <stef@bononline.nl>
Cc: autofs@linux.kernel.org

Stef Bon wrote:
> Hello,
> 
> 
> I'm using a construction where the automounter is started when a
> sessions starts, using ConsoleKit.
> Look at:
> http://linux.bononline.nl/linux/fuse-workspace/index.php
> 
> 
> I'm using the feature of ConsoleKit to run a script/program when a
> session is added, and when it's removed, in
> /etc/ConsoleKit/run.d.
> 
> Now here some environmentvariables are set by ConsoleKit, indicating the
> user, the seat and the session, and more.
> 
> Part of my construction is a wrapper shell script around mount.cifs,
> which calls mount.cifs with the right parameters.
> It's a sh script. Now I've found out that the environmentvariables set
> by ConsoleKit are still set when this script is run.
> It looks like the mount.md5key (this is the name of the wrapper) shell
> script is using the same environment as when the
> automounter is started.
> 
> Is this right??

Programs do generally inherit the environment within which they are
started. So yes, of course.

Ian
