From: Joe Pruett <joey@clean.q7.com>
Subject: Re: cross automount issue
Date: Fri, 7 Apr 2006 09:24:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604070923300.15746@q7.q7.com>
References: <Pine.LNX.4.64.0604062047510.13380@q7.q7.com>
	<Pine.LNX.4.58.0604072342530.24984@wombat.indigo.net.au>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0604072342530.24984@wombat.indigo.net.au>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

after sending it, i started wondering what the lock was there for.  i 
wasn't sure if each automount daemon was multi-threaded or not.  what 
mount locking are you referring to?
