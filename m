From: "Bryan O'Sullivan" <bos@serpentine.com>
Subject: Severe problem with 4.1.2: automount caches NIS maps forever
Date: Thu, 06 May 2004 10:39:23 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1083865163.18740.6.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

Hi -

The autofs 4.1.2 release has a change in behaviour from earlier releases
(4.1.0, I think, and 4.0.0 for sure) in that it never checks to see if a
NIS-based automount map has changed.  This means that if I change the
location of an autofs-mounted filesystem, I have to SIGHUP the automount
daemons on every machine that care about that filesystem so that they'll
forget the contents of the map and reload it.

Needless to say, this doesn't scale in even a tiny way :-(

	<b
