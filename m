From: "aptosca" <aptosca@esseff.org>
Subject: getting parameters to executable maps
Date: Thu, 8 Jun 2006 14:27:16 -0700
Message-ID: <000101c68b42$54bc0b30$ce054c09@almaden.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

I've been looking for a way to get a parameter to an executable being used
as a map and have so far failed to come up with anything that will work. Has
this issue ever arisen? As far as I can tell, the exec of the program gets
nothing except the key being looked up. The program I'd like to have exec'd
needs just a little bit of context. It could be passed in through arguments
specified in the calling map, but autofs doesn't, for example, break the
string up at spaces for the exec call. Alternatively, if there were a way to
get at the args that were passed in the options string, that would work,
too, but again, I don't see anyway of making that happen.

Ideas?
Comments?
