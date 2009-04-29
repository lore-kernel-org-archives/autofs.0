From: Marc Weber <marco-oweber@gmx.de>
Subject: Which version to uses, nsswitch.conf parse errors
Date: Thu, 30 Apr 2009 00:50:27 +0200
Message-ID: <20090429225027.GC17870@gmx.de>
References: <20090428201219.GC6042@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <49F7C75C.3070303@themaw.net>
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

Hi Ian,

Indeed you'r right. There wasn't a \n at the end.
I was sure I tried that. I did. I must have messed something up while
playing with the parser. the syntax clearly states source NL;
I'll do some further investigation.
Using automount compiled by the system there is no error anymore. Strange.
Anyway thanks to your great support!

Marc Weber
