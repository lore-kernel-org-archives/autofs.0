From: Ian Kent <raven@themaw.net>
Subject: Re: "Busy inodes after unmount. Self destruct in 5
	seconds..."
Date: Fri, 9 Apr 2004 13:35:48 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0404091334360.5256@raven.themaw.net>
References: <OF0078B5E3.8F68FF8C-ON85256E70.004AE836-04256E70.0052CA39@us.ibm.com>
	<Pine.LNX.4.58.0404091319060.5256@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0404091319060.5256@raven.themaw.net>
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
To: Raymond Prach <rprach@us.ibm.com>
Cc: autofs@linux.kernel.org

On Fri, 9 Apr 2004, Ian Kent wrote:

> 
> I've tried to duplicate this just now and am having trouble.
> 
> First, the version of mount that I'm using doesn't seem to hang the way it 
> used to. What version of util-linux (or mount) are you using? I have 
> 2.11y.
> 
> Second thing I notice is that autofs-4.1.2 discovers the bogus mount very 
> quickly (<1 sec) and so even with a stop watch I can't get the mount to 
> be active at the same time as the expire.
> 
> Hopefully some of this info will help.

Forgot kernel version info.

This is with a vanilla 2.4.24 kernel.

Ian
