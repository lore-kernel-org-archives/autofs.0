From: raven@themaw.net
Subject: Proposal for map refresh logic
Date: Fri, 21 May 2004 22:31:53 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0405212143160.1592@donald.themaw.net>
Mime-Version: 1.0
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs mailing list <autofs@linux.kernel.org>


Hi all,

Here are my thoughts on the automatic map refresh issue.

A few things to keep in mind are:

1. Re-reading a map also removes stale entries unless they are
   mounted. In this case they would not be removed until the
   refresh following their umount.

2. Using the success or failure of the mount operation is
   unreliable at best and could, at best, lead to unwanted
   map refreshes and at worst lead to a map reading storm.

3. For file maps we cannot read a single entry so instead
   the lookup of an individual entry amounts to checking the
   map files' modification time. This value will be recorded
   when the map is read.

4. We need to take advantage of hints that the map may have
   changed frequently in order to catch updated maps without
   a large time lag.

5. The HUP signal handling will remain to allow map refresh
   on demand.

There are two distinct cases to consider:

1. A map lookup results in a cache hit.
2. A map lookup results in a cache miss.

For a a cache hit we can:

1. Check if the map entry has exceeded a given time to live, say
   the map expire time.
2. If not continue as normal otherwise lookup the individual map
   entry and compare it to the cached entry.
3. If they are identical continue as normal otherwise it's a hint
   the map has changed so re-read it.

For a cache miss we can:

1. Lookup the individual map entry.
2. If this fails consider it as a real failure and continue.
3. If it succeeds re-read the entire map as it must be out of date.

This scheme avoids using the mount result as a hint.

It should give a reasonably frequent refresh interval particularly for 
map entries that change often.

One further consideration remains.

Should a time based (say 6-10 times the expire timeout) map refresh be 
added to the above logic?

I would prefer not as I'm not sure that it gets us much more than the 
above scheme. The main point being that the map will be out of date for 
an extended amount of time anyway and likely would be refreshed before
timeout anyway if it has changed and is frequent use. 

Comments please.

Ian
