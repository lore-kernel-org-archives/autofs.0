From: Ian Kent <raven@themaw.net>
Subject: Re: "Busy inodes after unmount. Self destruct in 5
	seconds..."
Date: Fri, 9 Apr 2004 09:30:03 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0404090925160.4861@raven.themaw.net>
References: <OF0078B5E3.8F68FF8C-ON85256E70.004AE836-04256E70.0052CA39@us.ibm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <OF0078B5E3.8F68FF8C-ON85256E70.004AE836-04256E70.0052CA39@us.ibm.com>
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

On Thu, 8 Apr 2004, Raymond Prach wrote:

> 4. Eventually, the script attempts to mount a home directory from a 
> workstation that is down or has been removed from the network, so it waits 
> around for a long time for the mount attempt to time out

Sorry to be a pest but looking at the changelog I see that I fixed a 
problem in the replicated server code that dealt with this situation in 
4.1.2 (latest release). So I guess I'm recommending 4.1.2 if you have the 
chance to try anything.

Ian
